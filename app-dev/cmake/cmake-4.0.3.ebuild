# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs cmake

DESCRIPTION="Cross platform Make"
HOMEPAGE="https://cmake.org/"
SRC_URI="https://github.com/Kitware/CMake/releases/download/v${PV}/${P}.tar.gz"

LICENSE="CMake"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="vim"

DEPEND="
	app-compression/libarchive
	app-dev/pkgconf
	app-net/curl
	lib-core/expat
	lib-core/zlib
	lib-dev/libuv
"

cmake_src_bootstrap() {
	replace-flags -O3 -O2
	append-flags -fpermissive
	# Cleanup args to extract only JOBS.
	# Because bootstrap does not know anything else.
	echo ${MAKEOPTS} | egrep -o '(\-j|\-\-jobs)(=?|[[:space:]]*)[[:digit:]]+' > /dev/null
	if [ $? -eq 0 ]; then
		par_arg=$(echo ${MAKEOPTS} | egrep -o '(\-j|\-\-jobs)(=?|[[:space:]]*)[[:digit:]]+' | tail -n1 | egrep -o '[[:digit:]]+')
		par_arg="--parallel=${par_arg}"
	else
		par_arg="--parallel=1"
	fi

	# disable running of cmake in boostrap command
	sed -i \
		-e '/"${cmake_bootstrap_dir}\/cmake"/s/^/#DONOTRUN /' \
		bootstrap || die "sed failed"

	tc-export CC CXX LD

	# bootstrap script isn't exactly /bin/sh compatible
	${CONFIG_SHELL:-sh} ./bootstrap \
		--prefix="${T}/cmakestrap/" \
		${par_arg} \
		|| die "Bootstrap failed"
}

cmake_src_test() {
	# fix OutDir and SelectLibraryConfigurations tests
	# these are altered thanks to our eclass
	sed -i -e 's:#IGNORE ::g' \
		"${S}"/Tests/{OutDir,CMakeOnly/SelectLibraryConfigurations}/CMakeLists.txt \
		|| die

	pushd "${BUILD_DIR}" > /dev/null

	local ctestargs
	[[ -n ${TEST_VERBOSE} ]] && ctestargs="--extra-verbose --output-on-failure"

	# Excluded tests:
	#    BootstrapTest: we actualy bootstrap it every time so why test it.
	#    BundleUtilities: bundle creation broken
	#    CTest.updatecvs: which fails to commit as root
	#    Fortran: requires fortran
	#    Qt4Deploy, which tries to break sandbox and ignores prefix
	#    RunCMake.CPack_RPM: breaks if app-compression/rpm is installed because
	#        debugedit binary is not in the expected location
	#    TestUpload, which requires network access
	"${BUILD_DIR}"/bin/ctest ${ctestargs} \
		-E "(BootstrapTest|BundleUtilities|CTest.UpdateCVS|Fortran|Qt4Deploy|RunCMake.CPack_RPM|TestUpload)" \
		|| die "Tests failed"

	popd > /dev/null
}

src_prepare() {
	append-flags -ffat-lto-objects

	cmake_src_prepare

	# Add gcc libs to the default link paths
	sed -i \
		-e "s|@GENTOO_PORTAGE_GCCLIBDIR@|${EPREFIX}/usr/${CHOST}/lib/|g" \
		-e "s|@GENTOO_PORTAGE_EPREFIX@|${EPREFIX}/|g" \
		Modules/Platform/{UnixPaths,Darwin}.cmake || die "sed failed"

	if ! has_version \>=${CATEGORY}/${PN}-3.10.0 ; then
		CMAKE_MAKEFILE_GENERATOR=emake
		CMAKE_BINARY="${S}/Bootstrap.cmk/cmake"
		cmake_src_bootstrap
	fi

	#remove default optimizations
	find ${S} -type f -print0 | xargs -0 sed -i 's/\-Wl,\-O2\ //g'
	find ${S} -type f -print0 | xargs -0 sed -i 's/\ \-O2//g'
	find ${S} -type f -print0 | xargs -0 sed -i 's/\-Wl,\-O2//g'
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DCMAKE_DATA_DIR=/share/${PN}
		-DSPHINX_MAN=OFF
		-DSPHINX_HTML=OFF
		-DCMAKE_USE_SYSTEM_LIBARCHIVE=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_BZIP2=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_CURL=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_EXPAT=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_LIBLZMA=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_ZLIB=ON
		-DCMAKE_USE_SYSTEM_LIBUV=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	use vim || rm -r "${ED}"/usr/share/vim || die

	rm -r "${ED}"/usr/doc || die

	#lazy update mtime
	find "${ED}"/usr/share -type f -exec touch {} +
}

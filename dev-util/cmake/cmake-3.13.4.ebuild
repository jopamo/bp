# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils flag-o-matic toolchain-funcs cmake-utils

DESCRIPTION="Cross platform Make"
HOMEPAGE="https://cmake.org/"
SRC_URI="https://github.com/Kitware/CMake/releases/download/v${PV}/cmake-${PV}.tar.gz"

LICENSE="CMake"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="doc qt5"

RDEPEND="
	>=app-compression/libarchive-3.0.0:=
	>=lib-dev/expat-2.0.1
	>=lib-dev/libuv-1.0.0:=
	>=app-net/curl-7.21.5[ssl]
	lib-sys/zlib
	dev-util/pkgconfig
	qt5? (
		gui-lib/qtcore:5
		gui-lib/qtgui:5
		gui-lib/qtwidgets:5
	)
"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
"

cmake_src_bootstrap() {
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
	cmake-utils_src_prepare

	# Add gcc libs to the default link paths
	sed -i \
		-e "s|@GENTOO_PORTAGE_GCCLIBDIR@|${EPREFIX}/usr/${CHOST}/lib/|g" \
		-e "s|@GENTOO_PORTAGE_EPREFIX@|${EPREFIX}/|g" \
		Modules/Platform/{UnixPaths,Darwin}.cmake || die "sed failed"

	if ! has_version \>=${CATEGORY}/${PN}-3.10.0 ; then
		CMAKE_BINARY="${S}/Bootstrap.cmk/cmake"
		cmake_src_bootstrap
	fi
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DCMAKE_DATA_DIR=/share/${PN}
		-DSPHINX_MAN=$(usex doc)
		-DSPHINX_HTML=$(usex doc)
		-DCMAKE_USE_SYSTEM_LIBRARY_LIBLZMA=ON
		-DCMAKE_USE_SYSTEM_LIBARCHIVE=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_CURL=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_EXPAT=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_ZLIB=ON
		-DCMAKE_USE_SYSTEM_LIBRARY_BZIP2=ON
		-DCMAKE_USE_SYSTEM_LIBUV=ON
	)

	if use qt5 ; then
		mycmakeargs+=(
			-DBUILD_QtDialog=ON
			$(cmake-utils_use_find_package qt5 Qt5Widgets)
		)
	fi

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	insinto /usr/share/vim/vimfiles/syntax
	doins Auxiliary/vim/syntax/cmake.vim

	insinto /usr/share/vim/vimfiles/indent
	doins Auxiliary/vim/indent/cmake.vim

	rm -r "${ED}"/usr/share/cmake/{completions,editors} || die
	rm -rf "${ED}"/usr/doc || die
}

# Distributed under the terms of the GNU General Public License v2

EAPI=7

RESTRICT="test"

inherit flag-o-matic python-single-r1 toolchain-funcs

MY_PV="$(ver_rs 1- _)"

DESCRIPTION="A system for large project software construction, simple to use and powerful"
HOMEPAGE="http://www.boost.org/doc/tools/build/index.html"
SRC_URI="https://downloads.sourceforge.net/project/boost/boost/${PV}/boost_${MY_PV}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python test"

RDEPEND="python? ( ${PYTHON_DEPS} )"

DEPEND="${RDEPEND}
	test? ( sys-app/diffutils
		${PYTHON_DEPS} )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
	test? ( ${PYTHON_REQUIRED_USE} )"

S="${WORKDIR}/boost_${MY_PV}/tools/build/src"

PATCHES=(
	"${FILESDIR}/${PN}-1.48.0-disable_python_rpath.patch"
	"${FILESDIR}/${PN}-1.50.0-respect-c_ld-flags.patch"
	"${FILESDIR}/${PN}-1.54.0-support_dots_in_python-buildid.patch"
	"${FILESDIR}/${PN}-1.66.0-add-none-feature-options.patch"
)

pkg_setup() {
	if use python || use test; then
		python-single-r1_pkg_setup
	fi
}

src_unpack() {
	tar xjf "${DISTDIR}/${A}" boost_${MY_PV}/tools/build || die "unpacking tar failed"
}

src_prepare() {
	default

	pushd ../ >/dev/null || die
	eapply "${FILESDIR}/${PN}-1.54.0-fix-test.patch"
	popd >/dev/null || die

	# Remove stripping option
	cd "${S}/engine" || die
	sed -i \
		-e 's|-s\b||' \
		-e "/libpython/s/lib ]/lib ]/" \
		build.jam || die "sed failed"

	# Force regeneration
	rm jambase.c || die

	# This patch allows us to fully control optimization
	# and stripping flags when bjam is used as build-system
	# We simply extend the optimization and debug-symbols feature
	# with empty dummies called 'none'
	cd "${S}" || die
	sed -i \
		-e 's/\(off speed space\)/\1 none/' \
		-e 's/\(debug-symbols      : on off\)/\1 none/' \
		tools/builtin.jam || die "sed failed"
}

src_configure() {
	if use python; then
		# replace versions by user-selected one (TODO: fix this when slot-op
		# deps are available to always match the best version available)
		sed -i \
			-e "s|27 26 25 24 23 22|${EPYTHON#python}|" \
			engine/build.jam || die "sed failed"
	fi
}

src_compile() {
	cd engine || die

	local toolset=cc

	CC=$(tc-getCC) ./build.sh ${toolset} -d+2 $(use_with python python "${EROOT%/}"/usr) || die "building bjam failed"
}

src_install() {
	dobin engine/bin.*/{bjam,b2}

	insinto /usr/share/boost-build
	doins -r "${FILESDIR}/site-config.jam" \
		../boost-build.jam bootstrap.jam build-system.jam ../example/user-config.jam *.py \
		build kernel options tools util

	if ! use python; then
		find "${ED%/}/usr/share/boost-build" -iname "*.py" -delete || die "removing experimental python files failed"
	fi

	dodoc ../notes/{changes,release_procedure,build_dir_option,relative_source_paths}.txt

	cleanup_install
}

src_test() {
	cd ../test || die

	export TMP="${T}"

	DO_DIFF="${PREFIX}/usr/bin/diff" ${PYTHON} test_all.py

	if [[ -s test_results.txt ]]; then
		eerror "At least one test failed: $(<test_results.txt)"
		die "tests failed"
	fi
}

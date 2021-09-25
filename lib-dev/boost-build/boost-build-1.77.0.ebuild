# Distributed under the terms of the GNU General Public License v2

EAPI=8

RESTRICT="test"

inherit flag-o-matic toolchain-funcs

MY_PV="$(ver_rs 1- _)"

DESCRIPTION="A system for large project software construction, simple to use and powerful"
HOMEPAGE="http://www.boost.org/doc/tools/build/index.html"
SRC_URI="https://downloads.sourceforge.net/project/boost/boost/${PV}/boost_${MY_PV}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="${RDEPEND}
	test? ( app-core/diffutils )
"

S="${WORKDIR}/boost_${MY_PV}/tools/build/src"

PATCHES=(
	"${FILESDIR}"/${PN}-1.71.0-disable_python_rpath.patch
	"${FILESDIR}"/${PN}-1.73.0-add-none-feature-options.patch
	"${FILESDIR}"/${PN}-1.76.0-respect-user-flags.patch
	"${FILESDIR}"/${PN}-1.74.0-no-implicit-march-flags.patch
)

src_unpack() {
	tar xojf "${DISTDIR}/${A}" boost_${MY_PV}/tools/build || die "unpacking tar failed"
}

src_prepare() {
	default

	pushd .. >/dev/null || die
	eapply "${FILESDIR}"/${PN}-1.71.0-fix-test.patch
	popd >/dev/null || die
}

src_compile() {
	cd engine || die
	${CONFIG_SHELL:-${BASH}} ./build.sh cxx --cxx="$(tc-getCXX)" --cxxflags="${CXXFLAGS}" -d+2 --without-python || die "building bjam failed"
}

src_test() {
	# Forget tests, bjam is a lost cause
	:
}

src_install() {
	dobin engine/{bjam,b2}

	insinto /usr/share/boost-build/src
	doins -r "${FILESDIR}/site-config.jam" \
		../boost-build.jam bootstrap.jam build-system.jam ../example/user-config.jam *.py \
		build kernel options tools util

	find "${ED}"/usr/share/boost-build/src -iname '*.py' -delete || die
}

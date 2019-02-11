# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib flag-o-matic

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="https://taglib.github.io/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1 MPL-1.1"
KEYWORDS="amd64 arm64"
SLOT="0"
IUSE="boost debug examples test"

RDEPEND="boost? ( dev-libs/boost:=[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.11-install-examples.patch
	"${FILESDIR}"/${P}-CVE-2017-12678.patch
)

MULTILIB_CHOST_TOOLS=(
	/usr/bin/taglib-config
)

src_prepare() {
	cmake-utils_src_prepare

	sed -e "s/BUILD_TESTS AND NOT BUILD_SHARED_LIBS/BUILD_TESTS/" \
		-i CMakeLists.txt \
		-i ConfigureChecks.cmake || die

	# bug 651744
	append-cxxflags -std=c++11
}

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(multilib_native_usex examples)
		$(cmake-utils_use_find_package boost Boost)
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TESTS=$(usex test)
	)

	cmake-utils_src_configure
}

multilib_src_test() {
	# ctest does not work
	emake -C "${BUILD_DIR}" check
}

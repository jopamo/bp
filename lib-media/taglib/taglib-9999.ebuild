# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic git-r3

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="https://taglib.github.io/"
EGIT_REPO_URI="https://github.com/taglib/taglib.git"

LICENSE="LGPL-2.1 MPL-1.1"
KEYWORDS="amd64 arm64"
SLOT="0"
IUSE="debug examples test"

DEPEND="${RDEPEND}
"

append-cxxflags -std=c++11

src_prepare() {
	cmake_src_prepare

	sed -e "s/BUILD_TESTS AND NOT BUILD_SHARED_LIBS/BUILD_TESTS/" \
		-i CMakeLists.txt \
		-i ConfigureChecks.cmake || die

	# bug 651744
	append-cxxflags -std=c++11
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_test() {
	# ctest does not work
	emake -C "${BUILD_DIR}" check
}

# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils python-any-r1

DESCRIPTION="C++ JSON reader and writer"
HOMEPAGE="https://github.com/open-source-parsers/jsoncpp"
SRC_URI="https://github.com/open-source-parsers/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( public-domain MIT )"
SLOT="0/22"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DJSONCPP_WITH_TESTS=$(usex test)
		-DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF
		-DJSONCPP_WITH_CMAKE_PACKAGE=ON

		-DBUILD_SHARED_LIBS=ON

		# Follow Debian, Ubuntu, Arch convention for headers location
		# bug #452234
		-DCMAKE_INSTALL_INCLUDEDIR=include/jsoncpp

		# Disable implicit ccache use
		-DCCACHE_FOUND=OFF
	)
	cmake-utils_src_configure
}

src_test() {
	cmake-utils_src_make jsoncpp_check
}

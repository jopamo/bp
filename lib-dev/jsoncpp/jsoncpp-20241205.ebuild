# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ JSON reader and writer"
HOMEPAGE="https://github.com/open-source-parsers/jsoncpp"

SNAPSHOT=dca8a24cf8da1fc61b5cf0422cad03474124196c
SRC_URI="https://github.com/open-source-parsers/jsoncpp/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( public-domain MIT )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DJSONCPP_WITH_TESTS=$(usex test)
		-DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF
		-DJSONCPP_WITH_CMAKE_PACKAGE=ON
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS=$(usex static-libs)
	)
	cmake_src_configure
}

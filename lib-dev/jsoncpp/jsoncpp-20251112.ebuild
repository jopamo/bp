# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ JSON reader and writer"
HOMEPAGE="https://github.com/open-source-parsers/jsoncpp"
SNAPSHOT=b511d9e64956db998b74909df112ac8c8f41d6ff
SRC_URI="https://github.com/open-source-parsers/jsoncpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/jsoncpp-${SNAPSHOT}

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

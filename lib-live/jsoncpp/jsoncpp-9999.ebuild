# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ JSON reader and writer"
HOMEPAGE="https://github.com/open-source-parsers/jsoncpp"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/open-source-parsers/jsoncpp.git"
else
	SNAPSHOT=
	SRC_URI="https://github.com/open-source-parsers/jsoncpp/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="|| ( public-domain MIT )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DJSONCPP_WITH_TESTS=$(usex test)
		-DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF
		-DJSONCPP_WITH_CMAKE_PACKAGE=ON
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_INSTALL_INCLUDEDIR=include/jsoncpp
	)
	cmake_src_configure
}

src_test() {
	cmake_src_make jsoncpp_check
}

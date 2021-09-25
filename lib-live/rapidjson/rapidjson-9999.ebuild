# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A fast JSON parser/generator for C++ with both SAX/DOM style API"
HOMEPAGE="http://rapidjson.org/"

LICENSE="MIT"
IUSE="test"
SLOT="0"

EGIT_REPO_URI="https://github.com/Tencent/rapidjson"
KEYWORDS="amd64"

src_configure() {
	local mycmakeargs=(
		-DRAPIDJSON_BUILD_TESTS=$(usex test)
		-DRAPIDJSON_BUILD_THIRDPARTY_GTEST=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -rf "${ED}"/usr/share/doc
}

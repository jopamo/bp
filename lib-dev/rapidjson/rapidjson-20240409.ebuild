# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A fast JSON parser/generator for C++ with both SAX/DOM style API"
HOMEPAGE="http://rapidjson.org/"

SNAPSHOT=ab1842a2dae061284c0a62dca1cc6d5e7e37e346
SRC_URI="https://github.com/Tencent/rapidjson/archive/${SNAPSHOT}.tar.gz -> rapidjson-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/rapidjson-${SNAPSHOT}"

LICENSE="MIT"
IUSE="test"
SLOT="0"

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

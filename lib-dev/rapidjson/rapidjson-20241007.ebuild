# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A fast JSON parser/generator for C++ with both SAX/DOM style API"
HOMEPAGE="http://rapidjson.org/"

SNAPSHOT=858451e5b7d1c56cf8f6d58f88cf958351837e53
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

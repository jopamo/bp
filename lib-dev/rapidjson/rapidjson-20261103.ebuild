# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="A fast JSON parser/generator for C++ with both SAX/DOM style API"
HOMEPAGE="http://rapidjson.org/"

SNAPSHOT=297637bc0a0f00dc504dbc1a47ebdaa577f8ae19
SRC_URI="https://github.com/Tencent/rapidjson/archive/${SNAPSHOT}.tar.gz -> rapidjson-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/rapidjson-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
IUSE="test"

KEYWORDS="amd64"

BDEPEND="test? ( lib-dev/gtest )"
RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}/rapidjson-system-gtest.patch" )

src_prepare() {
	cmake_src_prepare
	sed -i 's/ -Werror//g' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5
		-DRAPIDJSON_BUILD_TESTS=$(usex test)
	)
	qa-policy-configure
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -rf "${ED}"/usr/share/doc
	qa-policy-install
}

# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="A YAML parser and emitter in C++"
HOMEPAGE="https://github.com/jbeder/yaml-cpp"
SNAPSHOT=f473f3bdfed25271ebd3d268caedc1b0b7f5ff50
SRC_URI="https://github.com/jbeder/yaml-cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

BDEPEND="test? ( lib-dev/gtest )"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
		-DYAML_CPP_BUILD_TESTS=$(usex test ON OFF)
		-DYAML_USE_SYSTEM_GTEST=$(usex test ON OFF)
		-DYAML_BUILD_SHARED_LIBS=ON
		-DYAML_CPP_BUILD_TOOLS=ON
		-DYAML_CPP_BUILD_CONTRIB=ON
	)

	cmake_src_configure
}

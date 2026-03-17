# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A YAML parser and emitter in C++"
HOMEPAGE="https://github.com/jbeder/yaml-cpp"

SNAPSHOT=8a666a0c1e9d4f5662f780efc1689c9ff9c634e2
SRC_URI="https://github.com/jbeder/yaml-cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

BDEPEND="test? ( dev-cpp/gtest )"

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

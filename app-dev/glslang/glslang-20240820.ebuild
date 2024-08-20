# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Khronos reference front-end for GLSL and ESSL, and sample SPIR-V generator"
HOMEPAGE="https://www.khronos.org/opengles/sdk/tools/Reference-Compiler/ https://github.com/KhronosGroup/glslang"

SNAPSHOT=592de6cf78e0fb359fc3e2854c9dc0f3cf6d4820
SRC_URI="https://github.com/KhronosGroup/glslang/archive/${SNAPSHOT}.tar.gz -> glslang-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/glslang-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

src_configure() {
	append-flags -ffat-lto-objects

	local mycmakeargs=(
		-DENABLE_PCH=OFF
		-DALLOW_EXTERNAL_SPIRV_TOOLS=1
	)
	cmake_src_configure
}

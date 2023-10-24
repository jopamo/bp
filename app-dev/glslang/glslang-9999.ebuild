# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 flag-o-matic

DESCRIPTION="Khronos reference front-end for GLSL and ESSL, and sample SPIR-V generator"
HOMEPAGE="https://www.khronos.org/opengles/sdk/tools/Reference-Compiler/ https://github.com/KhronosGroup/glslang"
EGIT_REPO_URI="https://github.com/KhronosGroup/${PN}.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

PATCHES=( "${FILESDIR}/${PN}-1.3.236-Install-static-libs.patch" )

src_configure() {
	append-flags -ffat-lto-objects

	local mycmakeargs=(
		-DENABLE_PCH=OFF
		-DALLOW_EXTERNAL_SPIRV_TOOLS=1
	)
	cmake_src_configure
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Provides an API and commands for processing SPIR-V modules"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Tools"
EGIT_REPO_URI="https://github.com/KhronosGroup/SPIRV-Tools.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

DEPEND="~app-dev/spirv-headers-9999"

src_configure() {
	local mycmakeargs=(
		-DSPIRV-Headers_SOURCE_DIR="${ESYSROOT}"/usr/
		-DSPIRV_WERROR=OFF
		-DSPIRV_TOOLS_BUILD_STATIC=OFF
	)
	cmake_src_configure
}

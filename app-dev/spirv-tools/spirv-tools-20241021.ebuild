# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Provides an API and commands for processing SPIR-V modules"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-Tools"

SNAPSHOT=895bb9ffecc2c48646b50f77aeb85f5b70b9bb37
SRC_URI="https://github.com/KhronosGroup/SPIRV-Tools/archive/${SNAPSHOT}.tar.gz -> SPIRV-Tools-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SPIRV-Tools-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
#KEYWORDS="amd64 arm64"

RESTRICT="test"

DEPEND="app-dev/spirv-headers"

src_configure() {
	local mycmakeargs=(
		-DSPIRV-Headers_SOURCE_DIR="${ESYSROOT}"/usr/
		-DSPIRV_WERROR=OFF
		-DSPIRV_TOOLS_BUILD_STATIC=OFF
	)
	cmake_src_configure
}

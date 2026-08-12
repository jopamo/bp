# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Machine-readable files for the SPIR-V Registry"
HOMEPAGE="https://registry.khronos.org/SPIR-V/ https://github.com/KhronosGroup/SPIRV-Headers"
SNAPSHOT=f0bf307f7c49d26484db596185cece53c37701fc
SRC_URI="https://github.com/KhronosGroup/SPIRV-Headers/archive/${SNAPSHOT}.tar.gz -> SPIRV-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SPIRV-Headers-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

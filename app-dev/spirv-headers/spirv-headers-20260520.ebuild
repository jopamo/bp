# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Machine-readable files for the SPIR-V Registry"
HOMEPAGE="https://registry.khronos.org/SPIR-V/ https://github.com/KhronosGroup/SPIRV-Headers"
SNAPSHOT=8c5559c134abcf432ec59db842404087b9906c1a
SRC_URI="https://github.com/KhronosGroup/SPIRV-Headers/archive/${SNAPSHOT}.tar.gz -> SPIRV-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SPIRV-Headers-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

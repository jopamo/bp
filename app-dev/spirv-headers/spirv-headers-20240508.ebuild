# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Machine-readable files for the SPIR-V Registry"
HOMEPAGE="https://registry.khronos.org/SPIR-V/ https://github.com/KhronosGroup/SPIRV-Headers"

SNAPSHOT=49a1fceb9b1d087f3c25ad5ec077bb0e46231297
SRC_URI="https://github.com/KhronosGroup/SPIRV-Headers/archive/${SNAPSHOT}.tar.gz -> SPIRV-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SPIRV-Headers-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

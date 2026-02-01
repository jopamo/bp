# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Machine-readable files for the SPIR-V Registry"
HOMEPAGE="https://registry.khronos.org/SPIR-V/ https://github.com/KhronosGroup/SPIRV-Headers"
SNAPSHOT=04f10f650d514df88b76d25e83db360142c7b174
SRC_URI="https://github.com/KhronosGroup/SPIRV-Headers/archive/${SNAPSHOT}.tar.gz -> SPIRV-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SPIRV-Headers-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

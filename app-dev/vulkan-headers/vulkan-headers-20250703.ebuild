# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Vulkan Header files and API registry "
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Headers"
SNAPSHOT=2cd90f9d20df57eac214c148f3aed885372ddcfe
SRC_URI="https://github.com/KhronosGroup/Vulkan-Headers/archive/${SNAPSHOT}.tar.gz -> Vulkan-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Vulkan-Headers-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"

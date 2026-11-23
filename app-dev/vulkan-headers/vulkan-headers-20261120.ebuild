# Distributed under the terms of the GNU General Public License v2

inherit cmake

PROPERTIES+=" source-payload"

DESCRIPTION="Vulkan Header files and API registry"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Headers"
SNAPSHOT=d277a0a3cda9c682708c93279f0c72cd6b0ae3f3
SRC_URI="https://github.com/KhronosGroup/Vulkan-Headers/archive/${SNAPSHOT}.tar.gz -> Vulkan-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Vulkan-Headers-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"

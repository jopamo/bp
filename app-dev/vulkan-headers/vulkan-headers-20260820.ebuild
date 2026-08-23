# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Vulkan Header files and API registry"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Headers"
SNAPSHOT=b51f6b865c18fc5b33990d12f75e8dfd672cede6
SRC_URI="https://github.com/KhronosGroup/Vulkan-Headers/archive/${SNAPSHOT}.tar.gz -> Vulkan-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Vulkan-Headers-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"

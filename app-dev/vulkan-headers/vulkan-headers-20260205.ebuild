# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Vulkan Header files and API registry"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Headers"
SNAPSHOT=49f1a381e2aec33ef32adf4a377b5a39ec016ec4
SRC_URI="https://github.com/KhronosGroup/Vulkan-Headers/archive/${SNAPSHOT}.tar.gz -> Vulkan-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Vulkan-Headers-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"

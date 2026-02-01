# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Vulkan Header files and API registry"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Headers"
SNAPSHOT=3cfca3829608e778cf59b0dab55d77f4f6c79bee
SRC_URI="https://github.com/KhronosGroup/Vulkan-Headers/archive/${SNAPSHOT}.tar.gz -> Vulkan-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Vulkan-Headers-${SNAPSHOT}"

LICENSE="apache"
SLOT="0"
KEYWORDS="amd64 arm64"

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Unified C language headers for the OpenCL API"
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-Headers"

SNAPSHOT=862f06c64c222b683f22a872120fc066040dd2c8
SRC_URI="https://github.com/KhronosGroup/OpenCL-Headers/archive/${SNAPSHOT}.tar.gz -> OpenCL-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/OpenCL-Headers-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

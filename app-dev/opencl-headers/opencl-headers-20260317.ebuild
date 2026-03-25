# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="Unified C language headers for the OpenCL API"
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-Headers"
SNAPSHOT=e55138572c81dce15ffe402bd1142d9652ec5cb5
SRC_URI="https://github.com/KhronosGroup/OpenCL-Headers/archive/${SNAPSHOT}.tar.gz -> OpenCL-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/OpenCL-Headers-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

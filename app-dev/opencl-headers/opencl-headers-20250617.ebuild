# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Unified C language headers for the OpenCL API"
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-Headers"
SNAPSHOT=b79b358ff6b9998d3fc65a5f55083db3d651d55d
SRC_URI="https://github.com/KhronosGroup/OpenCL-Headers/archive/${SNAPSHOT}.tar.gz -> OpenCL-Headers-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/OpenCL-Headers-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

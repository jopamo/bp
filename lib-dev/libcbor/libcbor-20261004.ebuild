# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="CBOR protocol implementation for C and others"
HOMEPAGE="https://github.com/pjk/libcbor"
SNAPSHOT=ab8c72b1b26c0c3a6a462a11055bf7000a9d2ef5
SRC_URI="https://github.com/PJK/libcbor/archive/${SNAPSHOT}.tar.gz -> libcbor-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libcbor-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

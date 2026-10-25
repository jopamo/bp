# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="CBOR protocol implementation for C and others"
HOMEPAGE="https://github.com/pjk/libcbor"
SNAPSHOT=64c7bb932b2bee0b0c41e0c75098bbf51ae25547
SRC_URI="https://github.com/PJK/libcbor/archive/${SNAPSHOT}.tar.gz -> libcbor-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libcbor-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

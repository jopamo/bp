# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="CBOR protocol implementation for C and others"
HOMEPAGE="https://github.com/pjk/libcbor"
SNAPSHOT=0a54bbb4e023247fc6f2bcc250019d025d2963ad
SRC_URI="https://github.com/PJK/libcbor/archive/${SNAPSHOT}.tar.gz -> libcbor-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libcbor-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

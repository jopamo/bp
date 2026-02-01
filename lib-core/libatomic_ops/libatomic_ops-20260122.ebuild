# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Portable atomic operations library used by garbage collectors and concurrent code"
HOMEPAGE="https://github.com/ivmai/bdwgc"
SNAPSHOT=d007246aa70fef4f9bfcb84bcc5e6a97653b3d86
SRC_URI="https://github.com/bdwgc/libatomic_ops/archive/${SNAPSHOT}.tar.gz -> libatomic_ops-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libatomic_ops-${SNAPSHOT}

LICENSE="boehm-gc"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf --disable-docs
}

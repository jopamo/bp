# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://github.com/ivmai/bdwgc"
AOPS_URL="https://github.com/ivmai/libatomic_ops"

ATOMIC_OPS_VER=c0efdfe5a89180c5424e247a4d1ec753741788bc
SNAPSHOT=4d6cdc072663c1a22379d84acdac8a273ace1bc9
SRC_URI="
	https://github.com/ivmai/bdwgc/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz
	https://github.com/ivmai/libatomic_ops/archive/${ATOMIC_OPS_VER}.tar.gz -> libatomic_ops-${ATOMIC_OPS_VER}.tar.gz
"

S=${WORKDIR}/bdwgc-${SNAPSHOT}

LICENSE="boehm-gc"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	mv "${WORKDIR}/libatomic_ops-${ATOMIC_OPS_VER}" "${S}/libatomic_ops" || die

	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf --disable-docs
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://github.com/ivmai/bdwgc"
AOPS_URL="https://github.com/ivmai/libatomic_ops"

ATOMIC_OPS_VER=fa4df527300587cf3650d9bc89d008fbb823a663
SNAPSHOT=07a6d0ee8889bca5eaeadc13cabadc363725d216
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

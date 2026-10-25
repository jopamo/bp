# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://github.com/ivmai/bdwgc"
SNAPSHOT=fd3e9873c0674d356a44ac5eeb59d7f4936d5d86
SRC_URI="https://github.com/bdwgc/bdwgc/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/bdwgc-${SNAPSHOT}

LICENSE="boehm-gc"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-core/libatomic_ops"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf --disable-docs
}

# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://github.com/ivmai/bdwgc"
SNAPSHOT=82028767b45a56f4c5630de065ee6fdc2608cf1b
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

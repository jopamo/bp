# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://github.com/ivmai/bdwgc"

SNAPSHOT=e565bd803277321b7f30ba7be137253ef3155092
SRC_URI="https://github.com/ivmai/bdwgc/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
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

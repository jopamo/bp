# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://github.com/ivmai/bdwgc"

SNAPSHOT=24e7d4e77eeb4213d276557d7c08583ba10ecf6e
SRC_URI="https://github.com/ivmai/libatomic_ops/archive/${SNAPSHOT}.tar.gz -> libatomic_ops-${SNAPSHOT}.tar.gz"
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

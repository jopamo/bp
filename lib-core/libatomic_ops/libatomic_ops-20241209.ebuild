# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://github.com/ivmai/bdwgc"

SNAPSHOT=d40ec2903b6f6b50c9e6c08ea4b2aec34a7aa5fd
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

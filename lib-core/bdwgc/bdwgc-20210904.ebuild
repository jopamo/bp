# Distributed under the terms of the GNU General Public License v2

EAPI=8

ATOMIC_OPS_VER=807a4feccc6ef3882dbda212a3fe6fc4f9c4c5b6

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="http://www.hboehm.info/gc/ https://github.com/ivmai/bdwgc/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/ivmai/bdwgc.git"
	inherit git-r3
else
	SNAPSHOT=8faa9fc4e9c635457c84d68b9e5ecf8210572082
	SRC_URI="https://github.com/ivmai/bdwgc/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz
			https://github.com/ivmai/libatomic_ops/archive/${ATOMIC_OPS_VER}.tar.gz -> libatomic_ops-${ATOMIC_OPS_VER}.tar.gz"
	S=${WORKDIR}/bdwgc-${SNAPSHOT}
fi

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

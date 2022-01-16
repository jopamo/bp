# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="https://github.com/ivmai/bdwgc"
AOPS_URL=https://github.com/ivmai/libatomic_ops

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	ATOMIC_OPS_VER=914862752503cac5c3e7e5be8a8af2f5b97153a8
	SNAPSHOT=703232dd4131d247a43a0b0506ffc5ab5669a191
	SRC_URI="
		${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz
		${AOPS_URL}/archive/${ATOMIC_OPS_VER}.tar.gz -> libatomic_ops-${ATOMIC_OPS_VER}.tar.gz
	"
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

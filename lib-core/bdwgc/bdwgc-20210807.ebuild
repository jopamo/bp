# Distributed under the terms of the GNU General Public License v2

EAPI=7

ATOMIC_OPS_VER=86e09c58a4d4683216786637b4e9746ba87f0ec0

inherit autotools

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="http://www.hboehm.info/gc/ https://github.com/ivmai/bdwgc/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/ivmai/bdwgc.git"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=de8e2e986039495ed4416dcb61fe4fb34026a2dc
	SRC_URI="https://github.com/ivmai/bdwgc/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz
			https://github.com/ivmai/libatomic_ops/archive/${ATOMIC_OPS_VER}.tar.gz -> libatomic_ops-${ATOMIC_OPS_VER}.tar.gz"
	S=${WORKDIR}/bdwgc-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="boehm-gc"
SLOT="0"

src_prepare() {
	mv "${WORKDIR}/libatomic_ops-${ATOMIC_OPS_VER}" "${S}/libatomic_ops"

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-docs
		--with-libatomic-ops=no
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

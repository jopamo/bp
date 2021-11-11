# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="An assembler for x86 and x86_64 instruction sets"
HOMEPAGE="http://yasm.tortall.net/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/yasm/yasm"
	inherit git-r3
else
	SNAPSHOT=41762bead150fdae59687b35c8acd1c4ae0f1575
	SRC_URI="https://github.com/yasm/yasm/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD-2 BSD || ( Artistic GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--disable-nls
		--disable-rpath
		--disable-python
	)
	econf "${myconf}"
}

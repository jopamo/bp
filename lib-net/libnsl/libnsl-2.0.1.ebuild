# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Public client interface for NIS(YP) and NIS+ in a IPv6 ready version"
HOMEPAGE="https://github.com/thkukuk/libnsl"
SRC_URI="https://github.com/thkukuk/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0/2"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-net/libtirpc
"

src_prepare(){
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-shared
		--disable-static
		--enable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

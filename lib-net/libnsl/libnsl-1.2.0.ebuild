# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools multilib-minimal

DESCRIPTION="Public client interface for NIS(YP) and NIS+ in a IPv6 ready version"
HOMEPAGE="https://github.com/thkukuk/libnsl"
SRC_URI="https://github.com/thkukuk/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0/2"
LICENSE="LGPL-2.1+"

KEYWORDS="amd64 arm64 x86"

DEPEND="
	lib-net/libtirpc[${MULTILIB_USEDEP}]
"

src_prepare(){
	default
	eautoreconf
}

multilib_src_configure() {
	local myconf=(
		--enable-shared
		--disable-static
		--enable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install_all() {
	einstalldocs
	find "${ED}" -name '*.la' -delete || die
}

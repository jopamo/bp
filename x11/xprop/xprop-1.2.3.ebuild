# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal autotools

DESCRIPTION="property displayer for X"
SRC_URI="https://www.x.org/archive//individual/app/${P}.tar.gz"
SLOT=0

KEYWORDS="amd64 arm64 x86"

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11/xorgproto"

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

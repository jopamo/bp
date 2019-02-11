# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal autotools

DESCRIPTION="Shared memory fences using futexes"
SRC_URI="https://www.x.org/releases/individual/lib/${P}.tar.bz2"

SLOT=0
IUSE=static-libs
KEYWORDS="amd64 arm64"

DEPEND="x11/xorgproto"

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

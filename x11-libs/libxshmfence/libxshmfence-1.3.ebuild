# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Shared memory fences using futexes"
SRC_URI="https://www.x.org/releases/individual/lib/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE=static-libs

DEPEND="x11/xorgproto
	x11/util-macros"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

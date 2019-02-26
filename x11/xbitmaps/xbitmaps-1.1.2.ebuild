# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="X.Org bitmaps data"
SRC_URI="https://www.x.org/archive/individual/data/${P}.tar.bz2"
SLOT=0

KEYWORDS="amd64 arm64"

src_configure() {
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

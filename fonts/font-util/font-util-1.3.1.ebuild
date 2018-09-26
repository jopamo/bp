# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal

DESCRIPTION="X.Org font utilities"
SRC_URI="https://www.x.org/archive/individual/font/${P}.tar.bz2"
SLOT=0
KEYWORDS="amd64 arm64 x86"

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-mapdir=${EPREFIX}/usr/share/fonts/util 
		--with-fontrootdir=${EPREFIX}/usr/share/fonts
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

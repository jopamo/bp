# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools git-r3 gnome2-utils

DESCRIPTION="GNOME default icon theme"
HOMEPAGE="https://git.gnome.org/browse/adwaita-icon-theme/"

EGIT_REPO_URI="https://github.com/GNOME/adwaita-icon-theme.git"

LICENSE="
	|| ( LGPL-3 CC-BY-SA-3.0 )
"
SLOT="0"
KEYWORDS="amd64 arm64"

COMMON_DEPEND="
	gui-lib/gnome-common
	gui-lib/librsvg:2
"
RDEPEND="${COMMON_DEPEND}
	!<x11/gnome-themes-standard-3.14
"
DEPEND="${COMMON_DEPEND}
	x11-libs/gtk+:3
	sys-devel/gettext
	dev-util/pkgconfig
"
# This ebuild does not install any binaries
RESTRICT="binchecks strip"

src_prepare() {
	default
	eautoreconf
	sed -e 's:^\(cursordir.*\)icons\(.*\):\1cursors/xorg-x11\2:' \
		-i "${S}"/Makefile.am \
		-i "${S}"/Makefile.in || die
}

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

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

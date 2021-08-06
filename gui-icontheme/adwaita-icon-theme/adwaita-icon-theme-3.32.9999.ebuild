# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 xdg-utils

DESCRIPTION="Mostly private use system icons."
HOMEPAGE="https://git.gnome.org/browse/adwaita-icon-theme/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git"
EGIT_BRANCH="gnome-$(ver_cut 1)-$(ver_cut 2)"

LICENSE=" || ( LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-gui/gnome-common
	lib-gui/librsvg:2
	x11-libs/gtk+:3
	sys-devel/gettext
	dev-util/pkgconf"

RESTRICT="binchecks strip"

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

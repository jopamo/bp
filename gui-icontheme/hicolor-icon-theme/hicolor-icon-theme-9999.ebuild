# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 xdg-utils

DESCRIPTION="freedesktop default icon theme."
HOMEPAGE="https://gitlab.freedesktop.org/xdg/default-icon-theme.git"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xdg/default-icon-theme.git"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-gui/gnome-common
	lib-gui/librsvg:2
	x11-live-libs/gtk+:3
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

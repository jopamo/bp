# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg autotools git-r3 flag-o-matic

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"
EGIT_REPO_URI="https://github.com/audacious-media-player/audacious.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

PDEPEND="~xmedia-live-app/audacious-plugins-${PV}"

DEPEND="
	lib-dev/dbus-glib
	lib-live/glib
	xgui-live-lib/cairo
	xgui-live-lib/pango
	xgui-lib/qtbase
"
BDEPEND="app-dev/pkgconf"

append-flags -ffat-lto-objects

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-gtk
		--disable-nls
		--disable-valgrind
		--enable-dbus
		--enable-qt
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

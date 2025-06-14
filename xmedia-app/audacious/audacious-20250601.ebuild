# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg meson flag-o-matic

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"

SNAPSHOT=64cbfb3bb4adeabe47d8024ef99096de702d30f7
SRC_URI="https://github.com/audacious-media-player/audacious/archive/${SNAPSHOT}.tar.gz -> audacious-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/audacious-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

PDEPEND="xmedia-app/audacious-plugins"

DEPEND="
	lib-dev/dbus-glib
	lib-util/glib
	xgui-lib/cairo
	xgui-lib/pango
	xgui-lib/qtbase
"

src_configure() {
	append-flags -ffat-lto-objects

	local emesonargs=(
		-D gtk=false
		-D qt=true
		-D qt5=true
		)
		meson_src_configure
}

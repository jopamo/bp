# Distributed under the terms of the GNU General Public License v2

inherit xdg meson flag-o-matic

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"
SNAPSHOT=7037cb6a7cc5bfdff0ae3ff3bf0ef35c4d050573
SRC_URI="https://github.com/audacious-media-player/audacious/archive/${SNAPSHOT}.tar.gz -> audacious-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/audacious-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

PDEPEND="xmedia-app/audacious-plugins"

DEPEND="
	lib-dev/dbus-glib
	lib-core/glib
	xgui-lib/cairo
	xgui-lib/pango
	xgui-lib/qtbase:5
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

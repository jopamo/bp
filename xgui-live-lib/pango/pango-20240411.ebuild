# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"

SNAPSHOT=bc98a434e2c382736191a5092473c5f2368a8db8
SRC_URI="https://gitlab.gnome.org/GNOME/pango/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X +introspection test"

DEPEND="
	fonts/fontconfig
	lib-dev/fribidi
	lib-live/glib
	lib-live/json-glib
	xgui-live-lib/cairo
	xgui-live-lib/libXft
	xgui-misc/freetype
	xgui-misc/harfbuzz[glib(+),truetype(+)]
	introspection? ( lib-live/gobject-introspection )
"
BDEPEND="
	app-dev/gtk-doc-am
	app-dev/pkgconf
"

src_configure() {
	local emesonargs=(
		$(meson_feature introspection)
	)
	meson_src_configure
}

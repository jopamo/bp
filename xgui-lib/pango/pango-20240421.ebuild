# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"

SNAPSHOT=e75fc7d16218ec0e616f85b6b7f59509d1c7ec4a
SRC_URI="https://gitlab.gnome.org/GNOME/pango/-/archive/${SNAPSHOT}/pango-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X +introspection test"

DEPEND="
	fonts/fontconfig
	lib-dev/fribidi
	lib-util/glib
	lib-dev/json-glib
	xgui-lib/cairo
	xgui-lib/libXft
	xgui-misc/freetype
	xgui-misc/harfbuzz[glib(+),truetype(+)]
	introspection? ( lib-dev/gobject-introspection )
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

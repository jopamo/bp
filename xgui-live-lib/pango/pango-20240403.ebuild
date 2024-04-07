# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/pango"
#EGIT_BRANCH="pango-$(ver_cut 1)-$(ver_cut 2)"

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

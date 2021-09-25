# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/pango.git"
#EGIT_BRANCH="pango-$(ver_cut 1)-$(ver_cut 2)"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X +introspection test"

DEPEND="
	xgui-misc/harfbuzz[glib(+),truetype(+)]
	lib-live/glib
	xmedia-live-lib/fontconfig
	xgui-misc/freetype
	xgui-live-lib/cairo
	introspection? ( lib-live/gobject-introspection )
	xgui-live-lib/libXft
	lib-dev/fribidi
"
BDEPEND="
	dev-util/gtk-doc-am
	dev-util/pkgconf
"

src_configure() {
	local emesonargs=(
		$(meson_feature introspection)
	)
	meson_src_configure
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"
EGIT_REPO_URI="https://github.com/oaken-source/librsvg-og"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+introspection"

DEPEND="
	lib-live/glib
	xgui-live-lib/cairo
	xgui-live-lib/pango
	lib-core/libxml2
	lib-live/libcroco
	xgui-live-lib/gdk-pixbuf
	introspection? ( lib-live/gobject-introspection )
"
BDEPEND="
	lib-live/gobject-introspection-common
	dev-util/gtk-doc
	dev-util/pkgconf
"
src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-static
		--disable-tools
		--enable-pixbuf-loader
		$(use_enable introspection)
	)
	econf ${myconf[@]}
}

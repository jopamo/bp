# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"

SNAPSHOT=586e75f88d2deebfcfaa3f61338ffece26d3f521
SRC_URI="https://github.com/oaken-source/librsvg-og/archive/${SNAPSHOT}.tar.gz -> librsvg-og-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/librsvg-og-${SNAPSHOT}"

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
	app-dev/gtk-doc
	app-dev/pkgconf
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

# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"
EGIT_REPO_URI="https://github.com/oaken-source/librsvg-og.git"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="+introspection"

RDEPEND="
	>=lib-live/glib-2.34.3:2
	>=xgui-live-lib/cairo-1.12.14-r4
	>=x11-live-lib/pango-1.36.3
	>=lib-core/libxml2-2.9.1-r4:2
	>=lib-live/libcroco-0.6.8-r1
	x11-live-lib/gdk-pixbuf
	introspection? ( >=lib-live/gobject-introspection-0.10.8:= )
"
DEPEND="${RDEPEND}
	lib-live/gobject-introspection-common
	dev-util/gtk-doc
	dev-util/pkgconf
"
src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--disable-static
		--disable-tools
		$(use_enable introspection)
		--enable-pixbuf-loader
	)
	econf ${myconf[@]}
}


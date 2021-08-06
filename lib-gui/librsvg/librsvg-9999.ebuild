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
	>=lib-dev/glib-2.34.3:2
	>=lib-gui/cairo-1.12.14-r4
	>=x11-live-libs/pango-1.36.3
	>=lib-core/libxml2-2.9.1-r4:2
	>=lib-dev/libcroco-0.6.8-r1
	>=x11-live-libs/gdk-pixbuf-2.30.7:2[introspection]
	introspection? ( >=lib-dev/gobject-introspection-0.10.8:= )
"
DEPEND="${RDEPEND}
	lib-dev/gobject-introspection-common
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


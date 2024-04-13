# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+introspection"

DEPEND="
	lib-core/libxml2
	lib-util/glib
	lib-misc/libcroco
	virtual/rust
	xgui-lib/cairo
	xgui-lib/gdk-pixbuf
	xgui-lib/pango
	introspection? ( lib-dev/gobject-introspection )
"
BDEPEND="
	app-dev/gtk-doc
	app-dev/pkgconf
	virtual/rust
"

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-static
		--enable-pixbuf-loader
		$(use_enable introspection)
	)
	econf ${myconf[@]}
}

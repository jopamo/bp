# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 meson

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"

EGIT_REPO_URI="https://github.com/jopamo/librsvg"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection"

DEPEND="
	lib-core/libxml2
	lib-util/glib
	xgui-lib/cairo
	xgui-lib/gdk-pixbuf
	xgui-lib/pango
	introspection? ( lib-dev/gobject-introspection )
"
BDEPEND="
	app-dev/gtk-doc
	app-dev/pkgconf
"

append-flags -ffat-lto-objects

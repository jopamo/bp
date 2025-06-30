# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 meson

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"

EGIT_REPO_URI="https://github.com/GNOME/librsvg"
EGIT_BRANCH="librsvg-$(ver_cut 1).$(ver_cut 2)"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection"

RESTRICT="network-sandbox"

DEPEND="
	dev-rust/cargo-c
	lib-core/libxml2
	lib-util/glib
	virtual/rust
	xgui-lib/cairo
	xgui-lib/gdk-pixbuf
	xgui-lib/libcroco
	xgui-lib/pango
	introspection? ( lib-dev/gobject-introspection )
"
BDEPEND="
	app-dev/gtk-doc
	app-dev/pkgconf
"

src_prepare() {
	filter-flags -flto*

	default

	cargo update
}

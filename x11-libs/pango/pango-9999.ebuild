# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson git-r3

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"
EGIT_REPO_URI="https://github.com/GNOME/pango.git"

LICENSE="LGPL-2+ FTL"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="X +introspection test"

RDEPEND="
	>=lib-media/harfbuzz-1.2.3:=[glib(+),truetype(+)]
	>=lib-dev/glib-2.34.3:2
	>=lib-media/fontconfig-2.10.92:1.0=
	>=lib-media/freetype-2.5.0.1:2=
	>=lib-gui/cairo-1.12.14-r4:=
	introspection? ( >=lib-dev/gobject-introspection-0.9.5:= )
"
DEPEND="${RDEPEND}
	x11-libs/libXft
	>=dev-util/gtk-doc-am-1.20
	dev-util/pkgconf
	lib-dev/fribidi
"

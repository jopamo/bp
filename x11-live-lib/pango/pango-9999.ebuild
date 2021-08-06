# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/pango.git"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X +introspection test"

DEPEND="
	>=xmedia-live-lib/harfbuzz-1.2.3:=[glib(+),truetype(+)]
	>=lib-dev/glib-2.34.3:2
	xmedia-live-lib/fontconfig
	>=xmedia-live-lib/freetype-2.5.0.1:2=
	>=xgui-live-lib/cairo-1.12.14-r4:=
	introspection? ( >=lib-dev/gobject-introspection-0.9.5:= )
	x11-live-lib/libXft
	lib-dev/fribidi
"

BDEPEND="
	>=dev-util/gtk-doc-am-1.20
	dev-util/pkgconf
"

# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 multilib-minimal meson git-r3

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"
EGIT_REPO_URI="https://github.com/GNOME/pango.git"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="X +introspection test"

RDEPEND="
	>=lib-media/harfbuzz-1.2.3:=[glib(+),truetype(+),${MULTILIB_USEDEP}]
	>=lib-dev/glib-2.34.3:2[${MULTILIB_USEDEP}]
	>=lib-media/fontconfig-2.10.92:1.0=[${MULTILIB_USEDEP}]
	>=lib-media/freetype-2.5.0.1:2=[${MULTILIB_USEDEP}]
	>=x11-libs/cairo-1.12.14-r4:=[${MULTILIB_USEDEP}]
	introspection? ( >=lib-dev/gobject-introspection-0.9.5:= )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.20
	dev-util/pkgconfig[${MULTILIB_USEDEP}]
	lib-dev/fribidi
"

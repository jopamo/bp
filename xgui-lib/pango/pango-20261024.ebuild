# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"
SNAPSHOT=68e981d243d50e03f3df12fb400f31647ef570d2
SRC_URI="https://github.com/GNOME/pango/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection test"

DEPEND="
	fonts/fontconfig
	lib-dev/fribidi
	>=lib-core/glib-2.88
	xgui-lib/cairo
	xgui-lib/freetype
	xgui-lib/harfbuzz[glib(+),truetype(+)]
	introspection? ( lib-dev/gobject-introspection )
"

PATCHES=( "${FILESDIR}/${PN}-20261024-unused-state.patch" )

src_configure() {
	local emesonargs=(
		$(meson_feature introspection)
	)
	meson_src_configure
}

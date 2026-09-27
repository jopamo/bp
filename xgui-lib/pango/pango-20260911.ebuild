# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"
SNAPSHOT=8e74c27c113c98664b77272d16b14bbce542c184
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

src_configure() {
	local emesonargs=(
		$(meson_feature introspection)
	)
	meson_src_configure
}

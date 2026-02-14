# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"
SNAPSHOT=be9b2fccec8645924aecc96b1de4520091299fdf
SRC_URI="https://github.com/GNOME/pango/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2+ FTL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection test"

DEPEND="
	fonts/fontconfig
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

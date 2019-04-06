# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils git-r3 xdg-utils

EGIT_REPO_URI="https://github.com/oferkv/phototonic.git"
KEYWORDS="amd64 arm64"
LICENSE="GPL-3"
SLOT="0"
IUSE="svg tiff"

RDEPEND="gui-lib/qtwidgets:5
	gui-lib/qtgui:5
	gui-lib/qtcore:5
	app-media/exiv2:=
	svg? ( gui-lib/qtsvg:5 )
	tiff? ( gui-lib/qtimageformats:5 )"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

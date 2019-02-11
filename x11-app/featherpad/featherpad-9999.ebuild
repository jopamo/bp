# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils xdg-utils git-r3

DESCRIPTION="Lightweight Qt5 Plain-Text Editor"
HOMEPAGE="https://github.com/tsujan/FeatherPad"
EGIT_REPO_URI="https://github.com/tsujan/FeatherPad.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	gui-lib/qtcore:5
	gui-lib/qtgui:5
	gui-lib/qtprintsupport:5
	gui-lib/qtsvg:5
	gui-lib/qtx11extras
	gui-lib/qtnetwork
"
DEPEND="${RDEPEND}
"

src_configure() {
	eqmake5 fp.pro \
		PREFIX="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}


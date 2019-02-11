# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils xdg-utils git-r3

DESCRIPTION="a simple & lightweight desktop-agnostic Qt file archiver"
HOMEPAGE="https://github.com/lxqt/lxqt-archiver"
KEYWORDS="amd64 arm64"
EGIT_REPO_URI="https://github.com/lxqt/lxqt-archiver.git"

LICENSE="GPL-2+"
SLOT="0"

DEPEND=">=lib-dev/glib-2.18:2
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	gui-lib/linguist-tools:5
	>=dev-util/intltool-0.40
	lib-dev/json-glib
	app-compression/p7zip
	app-compression/unrar
	dev-util/pkgconfig"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}


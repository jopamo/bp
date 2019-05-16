# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg-utils

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="https://github.com/lxqt/pcmanfm-qt"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://www.github.com/lxqt/${PN}"
else
	SNAPSHOT=9458ba41d94327ab833e1134d76c4eb67a7a799b
	SRC_URI="https://github.com/lxqt/pcmanfm-qt/archive/${SNAPSHOT}.zip -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2+"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND=">=lib-dev/glib-2.18:2
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	>=x11-libs/libfm-1.2.0:=
	x11-libs/libfm-qt:=
	x11-libs/libxcb:=
	gui-lib/linguist-tools:5
	>=dev-util/intltool-0.40"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}


# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils xdg-utils

DESCRIPTION="Lightweight Qt image viewer from the LXQt Project"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://github.com/lxqt/${PN}/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="|| ( GPL-2+ LGPL-2.1+ )"
SLOT="0"

RDEPEND="
	lib-dev/glib:2
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtprintsupport:5
	gui-lib/qtsvg:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	lib-media/libexif
	>=x11-libs/libfm-1.2:=
	x11-libs/libfm-qt:=
	x11-libs/libX11
	x11-libs/libXfixes
"
DEPEND="${RDEPEND}
	gui-lib/linguist-tools:5
	>=dev-util/lxqt-build-tools-0.4.0
	gui-lib/liblxqt
	dev-util/pkgconf
"

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

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

DEPEND="
	lib-dev/glib:2
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras:5
	lib-media/libexif
	>=x11-live-lib/libfm-1.2:=
	x11-live-lib/libfm-qt:=
	x11-live-lib/libX11
	x11-live-lib/libXfixes
	xgui-live-lib/liblxqt
"
BDEPEND="
	dev-util/lxqt-build-tools
	dev-util/pkgconf
"

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

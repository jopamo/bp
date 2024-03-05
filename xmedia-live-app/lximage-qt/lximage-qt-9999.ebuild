# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Lightweight Qt image viewer from the LXQt Project"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/${PN}/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="|| ( GPL-2+ LGPL-2.1+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-live/glib
	xgui-live-lib/libX11
	xgui-live-lib/libXfixes
	xgui-live-lib/libfm
	xgui-live-lib/libfm-qt
	xgui-live-lib/liblxqt
	xgui-lib/qtbase
	xgui-lib/qtx11extras
	xmedia-live-lib/libexif
"
BDEPEND="
	app-dev/lxqt-build-tools
	app-dev/pkgconf
"

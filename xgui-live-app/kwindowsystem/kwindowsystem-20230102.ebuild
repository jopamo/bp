# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/KDE/kwindowsystem"
	inherit git-r3
else
	SNAPSHOT=73aabb04916dd1af1ddda423cae5980e5840fd6c
	SRC_URI="https://github.com/KDE/kwindowsystem/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X"

RESTRICT="test"

DEPEND="
	xgui-live-app/extra-cmake-modules
	xgui-lib/qtbase
	X? (
		xgui-lib/qtx11extras
		xgui-live-lib/libX11
		xgui-live-lib/libXfixes
		xgui-live-lib/libxcb
		xgui-live-lib/xcb-util-keysyms
		xgui-live-app/xorgproto
	)"

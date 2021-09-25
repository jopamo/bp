# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/KDE/kwindowsystem"
	inherit git-r3
else
	SNAPSHOT=b4bf29e297dd75eb2f4af6ed143839e223833b4b
	SRC_URI="https://github.com/KDE/kwindowsystem/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"

IUSE="X"

RESTRICT+=" test"

RDEPEND="xgui-live-app/extra-cmake-modules
		xgui-live-lib/qtbase
		X? (
			xgui-live-lib/qtx11extras
			xgui-live-lib/libX11
			xgui-live-lib/libXfixes
			xgui-live-lib/libxcb
			xgui-live-lib/xcb-util-keysyms
			xgui-live-app/xorgproto
	)"

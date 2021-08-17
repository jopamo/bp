# Distributed under the terms of the GNU General Public License v2

EAPI=7

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

RDEPEND="x11-live-misc/extra-cmake-modules
		xgui-live-lib/qtbase
		X? (
			xgui-live-lib/qtx11extras
			x11-live-lib/libX11
			x11-live-lib/libXfixes
			xgui-live-lib/libxcb
			x11-live-lib/xcb-util-keysyms
			x11-live-misc/xorgproto
	)"

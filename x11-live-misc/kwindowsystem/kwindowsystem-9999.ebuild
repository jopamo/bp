# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="Framework providing access to properties and features of the window manager"
EGIT_REPO_URI="https://github.com/KDE/kwindowsystem.git"

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X"

RESTRICT+=" test"

RDEPEND="x11-live-misc/extra-cmake-modules
		lib-gui/qtbase
		X? (
			lib-gui/qtx11extras
			x11-live-libs/libX11
			x11-live-libs/libXfixes
			lib-gui/libxcb
			x11-live-libs/xcb-util-keysyms
			x11-live-misc/xorgproto
	)"

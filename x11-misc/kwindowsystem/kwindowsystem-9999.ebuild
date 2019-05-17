# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Framework providing access to properties and features of the window manager"
EGIT_REPO_URI="https://github.com/KDE/kwindowsystem.git"

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="nls X"

RESTRICT+=" test"

RDEPEND="x11-misc/extra-cmake-modules
		gui-lib/qtgui
		gui-lib/qtwidgets
		nls? ( gui-lib/linguist-tools )
		X? (
			gui-lib/qtx11extras
			x11-libs/libX11
			x11-libs/libXfixes
			x11-libs/libxcb
			x11-libs/xcb-util-keysyms
			x11-misc/xorgproto
	)"

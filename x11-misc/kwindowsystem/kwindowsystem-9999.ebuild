# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Framework providing access to properties and features of the window manager"
EGIT_REPO_URI="https://github.com/KDE/kwindowsystem.git"

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="nls X"

RDEPEND="
	gui-lib/qtgui
	gui-lib/qtwidgets
	X? (
		gui-lib/qtx11extras
		x11-libs/libX11
		x11-libs/libXfixes
		x11-libs/libxcb
		x11-libs/xcb-util-keysyms
	)
"
DEPEND="${RDEPEND}
	nls? ( gui-lib/linguist-tools )
	X? ( x11-misc/xorgproto )
"

RESTRICT+=" test"

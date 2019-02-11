# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit qt5-build

DESCRIPTION="Linux/X11-specific support library for the Qt5 framework"
KEYWORDS="amd64 arm64"

RDEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}[xcb]
"
DEPEND="${RDEPEND}
	test? ( ~gui-lib/qtwidgets-${PV} )
"

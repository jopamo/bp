# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit qt5-build

DESCRIPTION="SVG rendering library for the Qt5 framework"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}
	~gui-lib/qtwidgets-${PV}
	>=lib-sys/zlib-1.2.5
"
DEPEND="${RDEPEND}
	test? ( ~gui-lib/qtxml-${PV} )
"

# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
VIRTUALX_REQUIRED="test"
inherit qt5-build

DESCRIPTION="Unit testing library for the Qt5 framework"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	~gui-lib/qtcore-${PV}
"
DEPEND="${RDEPEND}
	test? (
		~gui-lib/qtgui-${PV}
		~gui-lib/qtxml-${PV}
	)
"

QT5_TARGET_SUBDIRS=(
	src/testlib
)

QT5_GENTOO_PRIVATE_CONFIG=(
	:testlib
)

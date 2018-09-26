# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
inherit qt5-build

DESCRIPTION="Implementation of SAX and DOM for the Qt5 framework"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	~gui-lib/qtcore-${PV}
"
DEPEND="${RDEPEND}
	test? ( ~gui-lib/qtnetwork-${PV} )
"

QT5_TARGET_SUBDIRS=(
	src/xml
)

QT5_GENTOO_PRIVATE_CONFIG=(
	:xml
)

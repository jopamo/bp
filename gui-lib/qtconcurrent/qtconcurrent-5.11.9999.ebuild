# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
inherit qt5-build
DESCRIPTION="Multi-threading concurrence support library for the Qt5 framework"
KEYWORDS="amd64 arm64 x86"

DEPEND="
	~gui-lib/qtcore-${PV}
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/concurrent
)

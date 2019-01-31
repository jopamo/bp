# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qttools"
inherit qt5-build

DESCRIPTION="Qt5 module for integrating online documentation into applications"
KEYWORDS="amd64 arm64 x86"

DEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}
	~gui-lib/qtnetwork-${PV}
	~gui-lib/qtsql-${PV}[sqlite]
	~gui-lib/qtwidgets-${PV}
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/assistant/help
	src/assistant/qcollectiongenerator
	src/assistant/qhelpgenerator
)

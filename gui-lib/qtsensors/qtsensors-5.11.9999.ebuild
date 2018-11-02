# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qt5-build

DESCRIPTION="Hardware sensor access library for the Qt5 framework"

KEYWORDS="amd64 arm64 x86"

IUSE="qml"

RDEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtdbus-${PV}
	qml? ( ~gui-lib/qtdeclarative-${PV} )
"
DEPEND="${RDEPEND}"

src_prepare() {
	qt_use_disable_mod qml quick \
		src/src.pro

	qt5-build_src_prepare
}

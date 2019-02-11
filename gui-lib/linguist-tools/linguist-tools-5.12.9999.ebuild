# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qttools"
inherit qt5-build

DESCRIPTION="Tools for working with Qt translation data files"
KEYWORDS="amd64 arm64"

IUSE="qml"

DEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtxml-${PV}
	qml? ( ~gui-lib/qtdeclarative-${PV} )
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/linguist
)

src_prepare() {
	sed -i -e '/SUBDIRS += linguist/d' \
		src/linguist/linguist.pro || die

	qt_use_disable_mod qml qmldevtools-private \
		src/linguist/lupdate/lupdate.pro

	qt5-build_src_prepare
}

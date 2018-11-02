# Distributed under the terms of the GNU General Public License v2

EAPI=6

QT5_MODULE="qtlocation"

inherit qt5-build

DESCRIPTION="Physical position determination library for the Qt5 framework"

KEYWORDS="amd64 arm64 x86"

IUSE="geoclue qml"

RDEPEND="
	~gui-lib/qtcore-${PV}
	geoclue? ( ~gui-lib/qtdbus-${PV} )
	qml? ( ~gui-lib/qtdeclarative-${PV} )
"
DEPEND="${RDEPEND}"
PDEPEND="
	geoclue? ( app-misc/geoclue:0 )
"

QT5_TARGET_SUBDIRS=(
	src/3rdparty/clipper
	src/3rdparty/poly2tri
	src/3rdparty/clip2tri
	src/positioning
	src/plugins/position/positionpoll
)

pkg_setup() {
	use geoclue && QT5_TARGET_SUBDIRS+=(src/plugins/position/geoclue)
	use qml && QT5_TARGET_SUBDIRS+=(
		src/positioningquick
		src/imports/positioning
	)
}

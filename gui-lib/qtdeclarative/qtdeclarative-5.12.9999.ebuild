# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit python-any-r1 qt5-build

DESCRIPTION="The QML and Quick modules for the Qt5 framework"

KEYWORDS="amd64 arm64"

IUSE="gles2 localstorage +widgets xml"

COMMON_DEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}[gles2=]
	~gui-lib/qtnetwork-${PV}
	~gui-lib/qttest-${PV}
	localstorage? ( ~gui-lib/qtsql-${PV} )
	widgets? ( ~gui-lib/qtwidgets-${PV}[gles2=] )
	xml? (
		~gui-lib/qtnetwork-${PV}
		~gui-lib/qtxmlpatterns-${PV}
	)
"
DEPEND="${COMMON_DEPEND}
	${PYTHON_DEPS}
"
RDEPEND="${COMMON_DEPEND}
	!<gui-lib/qtquickcontrols-5.7:5
"

src_prepare() {
	qt_use_disable_mod localstorage sql \
		src/imports/imports.pro

	qt_use_disable_mod widgets widgets \
		src/src.pro \
		src/qmltest/qmltest.pro \
		tests/auto/auto.pro \
		tools/tools.pro \
		tools/qmlscene/qmlscene.pro \
		tools/qml/qml.pro

	qt_use_disable_mod xml xmlpatterns \
		src/imports/imports.pro \
		tests/auto/quick/quick.pro \
		tests/auto/quick/examples/examples.pro

	qt5-build_src_prepare
}

src_configure() {
	local myqmakeargs=(
		--
		-qml-debug
	)
	qt5-build_src_configure
}

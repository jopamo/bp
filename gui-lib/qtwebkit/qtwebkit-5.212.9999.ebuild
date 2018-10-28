# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_7 )
QT_MIN_VER="5.9.1:5"
inherit python-any-r1 qt5-build

DESCRIPTION="WebKit rendering library for the Qt5 framework (deprecated)"

KEYWORDS="amd64 arm64"

IUSE="geolocation gstreamer gles2 +jit multimedia opengl orientation printsupport qml test webchannel webp"
REQUIRED_USE="?? ( gstreamer multimedia )"

RDEPEND="
	lib-sys/sqlite
	lib-dev/icu:=
	lib-dev/libxml2:2
	lib-dev/libxslt
	>=gui-lib/qtcore-${QT_MIN_VER}[icu]
	>=gui-lib/qtgui-${QT_MIN_VER}
	>=gui-lib/qtnetwork-${QT_MIN_VER}
	>=gui-lib/qtsql-${QT_MIN_VER}
	>=gui-lib/qtwidgets-${QT_MIN_VER}
	lib-media/fontconfig:1.0
	lib-media/libpng:0=
	>=lib-sys/zlib-1.2.5
	lib-media/libjpeg-turbo
	lib-media/mesa
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXrender
	geolocation? ( >=gui-lib/qtpositioning-${QT_MIN_VER} )
	gstreamer? (
		lib-dev/glib:2
		lib-media/gstreamer:1.0
		lib-media/gst-plugins-base:1.0
	)
	multimedia? ( >=gui-lib/qtmultimedia-${QT_MIN_VER}[widgets] )
	opengl? (
		>=gui-lib/qtgui-${QT_MIN_VER}[gles2=]
		>=gui-lib/qtopengl-${QT_MIN_VER}
	)
	orientation? ( >=gui-lib/qtsensors-${QT_MIN_VER} )
	printsupport? ( >=gui-lib/qtprintsupport-${QT_MIN_VER} )
	qml? ( >=gui-lib/qtdeclarative-${QT_MIN_VER} )
	webchannel? ( >=gui-lib/qtwebchannel-${QT_MIN_VER} )
	webp? ( lib-media/libwebp:0= )
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-util/gperf
	sys-devel/bison
	sys-devel/flex
	test? ( >=gui-lib/qttest-${QT_MIN_VER} )
"

src_prepare() {
	qt5-build_src_prepare
}

src_install() {
	qt5-build_src_install
}

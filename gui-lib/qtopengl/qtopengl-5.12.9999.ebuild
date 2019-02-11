# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
VIRTUALX_REQUIRED="test"
inherit qt5-build

DESCRIPTION="OpenGL support library for the Qt5 framework (deprecated)"
KEYWORDS="amd64 arm64"

IUSE="gles2"

DEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}[gles2=]
	~gui-lib/qtwidgets-${PV}[gles2=]
	lib-media/mesa
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/opengl
)

src_configure() {
	cp -r src/gui/opengl/* src/opengl/
	local myconf=(
		-opengl $(usex gles2 es2 desktop)
	)
	qt5-build_src_configure
}

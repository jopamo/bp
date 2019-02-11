# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
VIRTUALX_REQUIRED="test"
inherit qt5-build

DESCRIPTION="Printing support library for the Qt5 framework"
KEYWORDS="amd64 arm64"

IUSE="cups gles2"

RDEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}[gles2=]
	~gui-lib/qtwidgets-${PV}[gles2=]
	cups? ( >=lib-print/cups-1.4 )
"
DEPEND="${RDEPEND}
	test? ( ~gui-lib/qtnetwork-${PV} )
"

QT5_TARGET_SUBDIRS=(
	src/printsupport
	src/plugins/printsupport
)

QT5_GENTOO_CONFIG=(
	cups
)

src_configure() {
	local myconf=(
		$(qt_use cups)
		-opengl $(usex gles2 es2 desktop)
	)
	qt5-build_src_configure
}

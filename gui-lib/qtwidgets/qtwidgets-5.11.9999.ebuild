# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
inherit qt5-build

DESCRIPTION="Set of components for creating classic desktop-style UIs for the Qt5 framework"

KEYWORDS="amd64 arm64 x86"

# keep IUSE defaults in sync with qtgui
IUSE="gles2 gtk +png +xcb"

DEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}[gles2=,png=,xcb?]
	gtk? (
		~gui-lib/qtgui-${PV}[dbus]
		x11-libs/gtk+:3
		x11-libs/libX11
		x11-libs/pango
	)
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/tools/uic
	src/widgets
	src/plugins/platformthemes
)

QT5_GENTOO_CONFIG=(
	gtk:gtk3:
	::widgets
	!:no-widgets:
)

QT5_GENTOO_PRIVATE_CONFIG=(
	:widgets
)

src_configure() {
	local myconf=(
		-opengl $(usex gles2 es2 desktop)
		$(qt_use gtk)
		-gui
		$(qt_use png libpng system)
		-widgets
		$(qt_use xcb xcb system)
		$(qt_use xcb xkbcommon system)
		$(usex xcb '-xcb-xlib -xinput2 -xkb' '')
	)
	qt5-build_src_configure
}

# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils xdg-utils git-r3 flag-o-matic

DESCRIPTION="WebKit rendering library for the Qt5 framework (deprecated)"
EGIT_REPO_URI="https://code.qt.io/qt/qtwebkit.git"
EGIT_BRANCH="5.9"
KEYWORDS="amd64 arm64"
SLOT=0

RDEPEND="
	lib-sys/sqlite
	lib-dev/icu:=
	lib-dev/libxml2:2
	lib-dev/libxslt
	gui-lib/qtcore
	gui-lib/qtgui
	gui-lib/qtnetwork
	gui-lib/qtsql
	gui-lib/qtwidgets
	lib-media/fontconfig:1.0
	lib-media/libpng:0=
	>=lib-sys/zlib-1.2.5
	lib-media/libjpeg-turbo
	lib-media/mesa
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXrender
"
DEPEND="${RDEPEND}
	dev-util/gperf
	sys-devel/bison
	sys-devel/flex
"

src_configure() {
	append-flags -fno-strict-aliasing
	eqmake5 WebKit.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

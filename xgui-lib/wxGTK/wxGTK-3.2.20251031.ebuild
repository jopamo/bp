# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2)"

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"
HOMEPAGE="https://wxwidgets.org/"
SNAPSHOT=33d52db86759218d71ff10b688a61281c1aa3c4b
SRC_URI="https://github.com/wxWidgets/wxWidgets/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/wxWidgets-${SNAPSHOT}"

LICENSE="wxWinLL-3 GPL-2"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="X aqua debug opengl sdl tiff"

RDEPEND="
	lib-core/expat
	sdl? ( xmedia-live-lib/libsdl )
	X? (
		lib-core/zlib
		lib-util/glib
		xgui-lib/cairo
		xgui-lib/gdk-pixbuf
		xgui-lib/gtk3
		xgui-lib/libSM
		xgui-lib/libX11
		xgui-lib/libXxf86vm
		xgui-lib/pango
		xmedia-lib/libjpeg-turbo
		xmedia-lib/libpng
		opengl? ( xgui-tools/mesa )
		tiff?   ( xmedia-lib/tiff )
		)
	aqua? (
		xgui-lib/gtk3[aqua]
		xmedia-lib/libjpeg-turbo
		tiff?   ( xmedia-lib/tiff )
		)"

DEPEND="${RDEPEND}
	app-dev/pkgconf
	opengl? ( xmedia-lib/glu )
	X? (
		xgui-tools/xorgproto
	)"

src_configure() {
	local myconf=(
		$(use_with opengl)
		$(use_with sdl)
		$(use_with tiff libtiff sys)
		--enable-compat28
		--enable-graphics_ctx
		--enable-gui
		--with-expat=sys
		--with-gtk=3
		--with-gtkprint
		--with-libjpeg=sys
		--with-libpng=sys
		--with-zlib=sys
		--without-gnomevfs
	)
	ECONF_SOURCE="${S}" econf ${myconf}
}

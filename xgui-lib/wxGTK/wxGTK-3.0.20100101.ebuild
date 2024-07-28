# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"
HOMEPAGE="https://wxwidgets.org/"

SNAPSHOT=9343c6d3232b131c0295886a5949a673ee0a8c5f
SRC_URI="https://github.com/wxWidgets/wxWidgets/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/wxWidgets-${SNAPSHOT}"

LICENSE="wxWinLL-3 GPL-2"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="+X aqua debug opengl sdl tiff"

RDEPEND="
	lib-core/expat
	sdl? ( xmedia-live-lib/libsdl )
	X? (
		lib-util/glib
		xmedia-lib/libpng
		lib-core/zlib
		xmedia-lib/libjpeg-turbo
		xgui-lib/cairo
		xgui-lib/gtk3
		xgui-lib/gdk-pixbuf
		xgui-lib/libSM
		xgui-lib/libX11
		xgui-lib/libXxf86vm
		xgui-lib/pango
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
		--with-zlib=sys
		--with-expat=sys
		--enable-compat28
		$(use_with sdl)
		--enable-graphics_ctx
		--with-gtkprint
		--enable-gui
		--with-gtk=3
		--with-libpng=sys
		--with-libjpeg=sys
		--without-gnomevfs
		$(use_with opengl)
		$(use_with tiff libtiff sys)
	)
	ECONF_SOURCE="${S}" econf ${myconf}
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"
HOMEPAGE="https://wxwidgets.org/"
EGIT_REPO_URI="https://github.com/wxWidgets/wxWidgets.git"
EGIT_BRANCH="WX_$(ver_cut 1)_$(ver_cut 2)_BRANCH"

LICENSE="wxWinLL-3 GPL-2"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="+X aqua debug opengl sdl tiff"

RDEPEND="
	lib-core/expat
	sdl? ( xmedia-live-lib/libsdl )
	X? (
		lib-live/glib
		xmedia-live-lib/libpng
		lib-core/zlib
		xmedia-live-lib/libjpeg-turbo
		xgui-live-lib/cairo
		xgui-live-lib/gtk+:3
		xgui-live-lib/gdk-pixbuf
		xgui-live-lib/libSM
		xgui-live-lib/libX11
		xgui-live-lib/libXxf86vm
		xgui-live-lib/pango
		opengl? ( xmedia-live-lib/mesa )
		tiff?   ( xmedia-live-lib/tiff )
		)
	aqua? (
		xgui-live-lib/gtk+:3[aqua]
		xmedia-live-lib/libjpeg-turbo
		tiff?   ( xmedia-live-lib/tiff )
		)"

DEPEND="${RDEPEND}
	app-dev/pkgconf
	opengl? ( xmedia-live-lib/glu )
	X? (
		xgui-live-app/xorgproto
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

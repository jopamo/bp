# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"
HOMEPAGE="https://wxwidgets.org/"
EGIT_REPO_URI="https://github.com/wxWidgets/wxWidgets.git"
EGIT_BRANCH="WX_$(ver_cut 1)_$(ver_cut 2)_BRANCH"

LICENSE="wxWinLL-3 GPL-2 doc? ( wxWinFDL-3 )"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="+X aqua doc debug opengl sdl tiff"

RDEPEND="
	lib-dev/expat
	sdl? ( lib-media/libsdl )
	X? (
		>=lib-dev/glib-2.22:2
		lib-media/libpng:0=
		lib-sys/zlib
		lib-media/libjpeg-turbo
		xgui-live-lib/cairo
		x11-live-lib/gtk+:3
		x11-live-lib/gdk-pixbuf
		x11-live-lib/libSM
		x11-live-lib/libX11
		x11-live-lib/libXxf86vm
		x11-live-lib/pango
		opengl? ( lib-media/mesa )
		tiff?   ( lib-media/tiff:0 )
		)
	aqua? (
		x11-live-lib/gtk+:3[aqua]
		lib-media/libjpeg-turbo:0=
		tiff?   ( lib-media/tiff:0 )
		)"

DEPEND="${RDEPEND}
	dev-util/pkgconf
	opengl? ( lib-media/glu )
	X? (
		x11-live-misc/xorgproto
	)"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
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

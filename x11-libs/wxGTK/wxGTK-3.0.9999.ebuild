# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"
HOMEPAGE="https://wxwidgets.org/"
EGIT_REPO_URI="https://github.com/wxWidgets/wxWidgets.git"
EGIT_BRANCH="WX_3_0_BRANCH"

KEYWORDS="amd64 arm64"
IUSE="+X aqua doc debug opengl sdl tiff"

SLOT="3.0-gtk3"

RDEPEND="
	lib-dev/expat
	sdl? ( lib-media/libsdl )
	X? (
		>=lib-dev/glib-2.22:2
		lib-media/libpng:0=
		lib-sys/zlib
		lib-media/libjpeg-turbo
		x11-libs/cairo
		x11-libs/gtk+:3
		x11-libs/gdk-pixbuf
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXxf86vm
		x11-libs/pango
		opengl? ( lib-media/mesa )
		tiff?   ( lib-media/tiff:0 )
		)
	aqua? (
		x11-libs/gtk+:3[aqua]
		lib-media/libjpeg-turbo:0=
		tiff?   ( lib-media/tiff:0 )
		)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	opengl? ( lib-media/glu )
	X? (
		x11/xorgproto
	)"

LICENSE="wxWinLL-3 GPL-2 doc? ( wxWinFDL-3 )"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
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

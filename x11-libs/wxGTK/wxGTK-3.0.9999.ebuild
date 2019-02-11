# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"
HOMEPAGE="https://wxwidgets.org/"
EGIT_REPO_URI="https://github.com/wxWidgets/wxWidgets.git"
EGIT_BRANCH="WX_3_0_BRANCH"

KEYWORDS="amd64 arm64"
IUSE="+X aqua doc debug opengl sdl tiff"

SLOT="3.0-gtk3"

RDEPEND="
	lib-dev/expat[${MULTILIB_USEDEP}]
	sdl? ( lib-media/libsdl[${MULTILIB_USEDEP}] )
	X? (
		>=lib-dev/glib-2.22:2[${MULTILIB_USEDEP}]
		lib-media/libpng:0=[${MULTILIB_USEDEP}]
		lib-sys/zlib[${MULTILIB_USEDEP}]
		lib-media/libjpeg-turbo[${MULTILIB_USEDEP}]
		x11-libs/cairo[${MULTILIB_USEDEP}]
		x11-libs/gtk+:3[${MULTILIB_USEDEP}]
		x11-libs/gdk-pixbuf[${MULTILIB_USEDEP}]
		x11-libs/libSM[${MULTILIB_USEDEP}]
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXxf86vm[${MULTILIB_USEDEP}]
		x11-libs/pango[${MULTILIB_USEDEP}]
		opengl? ( lib-media/mesa[${MULTILIB_USEDEP}] )
		tiff?   ( lib-media/tiff:0[${MULTILIB_USEDEP}] )
		)
	aqua? (
		x11-libs/gtk+:3[aqua=,${MULTILIB_USEDEP}]
		lib-media/libjpeg-turbo:0=[${MULTILIB_USEDEP}]
		tiff?   ( lib-media/tiff:0[${MULTILIB_USEDEP}] )
		)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig[${MULTILIB_USEDEP}]
	opengl? ( lib-media/glu[${MULTILIB_USEDEP}] )
	X? (
		x11/xorgproto[${MULTILIB_USEDEP}]
	)"

LICENSE="wxWinLL-3 GPL-2 doc? ( wxWinFDL-3 )"

multilib_src_configure() {
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

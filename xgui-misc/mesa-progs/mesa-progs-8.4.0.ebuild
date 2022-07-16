# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/progs/demos}"
MY_P="${MY_PN}-${PV}"

inherit autotools toolchain-funcs

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
SRC_URI="https://mesa.freedesktop.org/archive/demos/${MY_P}.tar.bz2
		https://mesa.freedesktop.org/archive/demos/${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="egl gles2"

RDEPEND="
	xgui-misc/mesa
	xgui-live-lib/libX11"
DEPEND="${RDEPEND}
	xgui-misc/glew
	xmedia-live-lib/glu
	xgui-live-app/xorgproto"


src_prepare() {
	default
	eautoreconf
}

src_compile() {
	emake -C src/xdemos glxgears glxinfo

	if use egl; then
		emake LDLIBS="-lEGL" -C src/egl/opengl/ eglinfo
		emake -C src/egl/eglut/ libeglut_x11.la
		emake LDLIBS="-lGL -lEGL -lX11 -lm" -C src/egl/opengl/ eglgears_x11

		if use gles2; then
			emake LDLIBS="-lGLESv2 -lEGL -lX11" -C src/egl/opengles2/ es2_info
			emake LDLIBS="-lGLESv2 -lEGL -lX11 -lm" -C src/egl/opengles2/ es2gears_x11
		fi
	fi
}

src_install() {
	dobin src/xdemos/{glxgears,glxinfo}
	if use egl; then
		dobin src/egl/opengl/egl{info,gears_x11}

		use gles2 && dobin src/egl/opengles2/es2{_info,gears_x11}
	fi
}

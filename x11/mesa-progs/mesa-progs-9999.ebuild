# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit base autotools toolchain-funcs git-r3

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"

EGIT_REPO_URI="https://anongit.freedesktop.org/git/mesa/demos.git"

KEYWORDS="amd64 arm64 x86"

LICENSE="LGPL-2"
SLOT="0"
IUSE="egl gles2"

RDEPEND="
	lib-media/mesa[egl?,gles2?]
	lib-media/mesa
	x11-libs/libX11"
DEPEND="${RDEPEND}
	lib-media/glew
	lib-media/glu
	x11/xorgproto"


src_prepare() {
	base_src_prepare
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

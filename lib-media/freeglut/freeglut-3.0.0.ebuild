# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-multilib

DESCRIPTION="A completely OpenSourced alternative to the OpenGL Utility Toolkit (GLUT) library"
HOMEPAGE="http://freeglut.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug static-libs"

# enabling GLES support seems to cause build failures
RDEPEND="lib-media/glu[${MULTILIB_USEDEP}]
	>=lib-media/mesa-7.0-r1[${MULTILIB_USEDEP}]
	>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXi-1.7.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXrandr-1.4.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXxf86vm-1.1.3[${MULTILIB_USEDEP}]
	abi_x86_32? ( !app-misc/emul-linux-x86-opengl[-abi_x86_32(-)] )"
# gles? ( lib-media/mesa[gles1,${MULTILIB_USEDEP}] )
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11/xorgproto"

src_configure() {
	local mycmakeargs=(
		"-DFREEGLUT_GLES=OFF"
		"-DFREEGLUT_BUILD_STATIC_LIBS=$(usex static-libs ON OFF)"
	)
#	$(cmake-utils_use gles FREEGLUT_GLES)
	cmake-multilib_src_configure
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="A completely OpenSourced alternative to the OpenGL Utility Toolkit (GLUT) library"
HOMEPAGE="http://freeglut.sourceforge.net/"
SNAPSHOT=07a3e80780c289b51bc723415ef41cef6b026aed
SRC_URI="https://github.com/freeglut/freeglut/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

# enabling GLES support seems to cause build failures
RDEPEND="xmedia-lib/glu
	>=xgui-tools/mesa-7.0-r1
	>=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	>=xgui-lib/libXi-1.7.2
	>=xgui-lib/libXrandr-1.4.2
	>=xgui-lib/libXxf86vm-1.1.3
"
DEPEND="${RDEPEND}
	app-dev/pkgconf
	xgui-tools/xorgproto"

append-flags -fcommon

src_configure() {
	local mycmakeargs=(
		-DFREEGLUT_GLES="OFF"
		-DFREEGLUT_BUILD_STATIC_LIBS="$(usex static-libs ON OFF)"
	)
	cmake_src_configure
}


# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
SNAPSHOT=
SRC_URI="https://gitlab.freedesktop.org/mesa/mesa/-/archive/${SNAPSHOT}/mesa-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/mesa-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland"

DEPEND="
	lib-core/expat
	lib-core/zlib
	xgui-lib/libdrm
	xgui-lib/libX11
	xgui-lib/libxshmfence
	xgui-lib/libXdamage
	xgui-lib/libXext
	xgui-lib/libXxf86vm
	xgui-lib/libxcb
	xgui-lib/libXfixes
	dev-python/mako
	xmedia-lib/libglvnd
	wayland? ( xgui-lib/wayland-protocols )
"

src_configure() {
	local emesonargs=(
		-Db_lto=false
		-Dplatforms="$(usex wayland 'wayland,x11' 'x11')"
		-Dgallium-drivers="swrast"
		-Dgallium-extra-hud=false
   	-Dgallium-nine=false
   	-Dgallium-opencl=disabled
   	-Dgallium-va=disabled
		-Ddri3=disabled
 		-Degl=disabled
   	-Dgallium-vdpau=disabled
 		-Dgbm=enabled
		-Dllvm=disabled
 		-Dosmesa=false
	   -Dgles1=disabled
	   -Dgles2=disabled
	   -Dglvnd=true
	   -Dopengl=true
	   -Dglx=dri
	   -Dshared-glapi=enabled
		-Dvulkan-drivers=""
		-Dlibunwind=disabled
	 	-Dlmsensors=disabled
   	-Dvalgrind=disabled
	)
	meson_src_configure
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/mesa/mesa.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland"

DEPEND="
	lib-core/expat
	lib-core/zlib
	xgui-live-lib/libdrm
	xgui-live-lib/libX11
	xgui-live-lib/libxshmfence
	xgui-live-lib/libXdamage
	xgui-live-lib/libXext
	xgui-live-lib/libXxf86vm
	xgui-live-lib/libxcb
	xgui-live-lib/libXfixes
	dev-python/mako
	xmedia-live-lib/libglvnd
	wayland? ( xgui-live-lib/wayland-protocols )
"

src_configure() {
	local emesonargs=(
		-Db_lto=false
		-Dplatforms="$(usex wayland 'wayland,x11' 'x11')"
		-Ddri-drivers=""
		-Dgallium-drivers="swrast"
		-Dgallium-extra-hud=false
    	-Dgallium-nine=false
    	-Dgallium-opencl=disabled
    	-Dgallium-va=disabled
    	-Dgallium-xvmc=disabled
		-Ddri3=disabled
  		-Degl=disabled
    	-Dgallium-vdpau=disabled
 		-Dgbm=enabled
		-Dllvm=false
 		-Dosmesa=false
	    -Dgles1=disabled
	    -Dgles2=disabled
	    -Dglvnd=true
	    -Dopengl=true
	    -Dglx=dri
	    -Dshared-glapi=enabled
		-Dvulkan-drivers=""
		-Dlibunwind=false
	  	-Dlmsensors=false
    	-Dvalgrind=false
	)
	meson_src_configure
}

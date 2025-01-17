# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
SNAPSHOT=e2fa6b6ea39ddb79adad3257ac65c558ea088f28
SRC_URI="https://gitlab.freedesktop.org/mesa/mesa/-/archive/${SNAPSHOT}/mesa-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/mesa-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland"

DEPEND="
	app-build/llvm
	dev-python/mako
	lib-core/expat
	lib-core/zlib
	xgui-lib/libX11
	xgui-lib/libXdamage
	xgui-lib/libXext
	xgui-lib/libXfixes
	xgui-lib/libXxf86vm
	xgui-lib/libdrm
	xgui-lib/libxcb
	xgui-lib/libxshmfence
	xmedia-lib/libglvnd
	wayland? ( xgui-lib/wayland-protocols )
"
BDEPEND="
	dev-python/pyyaml
"

src_configure() {
	local emesonargs=(
		-Db_lto=false
		-Ddri3=disabled
		-Degl=disabled
		-Dgallium-drivers="swrast,zink"
		-Dgallium-extra-hud=false
		-Dgallium-nine=false
		-Dgallium-opencl=disabled
		-Dgallium-va=disabled
		-Dgallium-vdpau=disabled
		-Dgbm=enabled
		-Dgles1=disabled
		-Dgles2=disabled
		-Dglvnd=true
		-Dglx=dri
		-Dlibunwind=disabled
		-Dllvm=enabled
		-Dlmsensors=disabled
		-Dopengl=true
		-Dosmesa=false
		-Dplatforms="$(usex wayland 'wayland,x11' 'x11')"
		-Dshared-glapi=enabled
		-Dvalgrind=disabled
		-Dvulkan-drivers=""
		)
	meson_src_configure
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2)"

inherit meson flag-o-matic

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
SNAPSHOT=837dfb8d62cb95ca04ee3e26e953ee7068ea06db
SRC_URI="https://gitlab.freedesktop.org/mesa/mesa/-/archive/${SNAPSHOT}/mesa-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/mesa-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland"

DEPEND="
	app-build/llvm
	app-dev/glslang
	dev-python/mako
	lib-core/expat
	lib-core/zlib
	xgui-lib/libdrm
	xgui-lib/libX11
	xgui-lib/libxcb
	xgui-lib/libXdamage
	xgui-lib/libXext
	xgui-lib/libXfixes
	xgui-lib/libxshmfence
	xgui-lib/libXxf86vm
	xgui-tools/libclc
	xgui-tools/spirv-llvm-translator
	xgui-tools/xrandr
	xmedia-lib/libglvnd
	wayland? ( xgui-lib/wayland-protocols )
"
BDEPEND="
	dev-python/ply
	dev-python/pyyaml
"

src_configure() {
	local emesonargs=(
		-Db_lto=true
		-Degl=enabled
		-Dgallium-drivers="iris,zink"
		-Dgallium-extra-hud=false
		-Dgallium-va=disabled
		-Dgbm=enabled
		-Dgles1=enabled
		-Dgles2=enabled
		-Dglvnd=enabled
		-Dglx=dri
		-Dlibunwind=disabled
		-Dllvm=enabled
		-Dlmsensors=disabled
		-Dopengl=true
		-Dplatforms="x11"
		-Dshared-glapi=enabled
		-Dvalgrind=disabled
		-Dvulkan-drivers="intel"
	)
	meson_src_configure
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="$(ver_cut 1-2)"

inherit meson flag-o-matic

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
SNAPSHOT=4369c24d8df72042ee6c0ad16858acdc07b66b92
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
	xgui-lib/libdrm
	xgui-lib/libX11
	xgui-lib/libxcb
	xgui-lib/libXdamage
	xgui-lib/libXext
	xgui-lib/libXfixes
	xgui-lib/libxshmfence
	xgui-lib/libXxf86vm
	xgui-tools/libclc
	xmedia-lib/libglvnd
	xgui-tools/spirv-llvm-translator
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
		-Dgallium-vdpau=disabled
		-Dgbm=enabled
		-Dgles1=enabled
		-Dgles2=enabled
		-Dglvnd=enabled
		-Dglx=dri
		-Dlibunwind=disabled
		-Dllvm=enabled
		-Dlmsensors=disabled
		-Dopengl=true
		-Dplatforms="x11,wayland"
		-Dshared-glapi=enabled
		-Dvalgrind=disabled
		-Dvulkan-drivers="intel"
	)
	meson_src_configure
}

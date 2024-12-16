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
	strip-flags
	filter-flags -flto*

	local -x CC=clang
		local -x CXX=clang++
		local -x CC="clang"
		local -x CPP="clang-cpp"
		local -x CXX="clang++"
		local -x AR="llvm-ar"
		local -x NM="llvm-nm"
		local -x RANLIB="llvm-ranlib"
		local -x LD="ld.lld"

	local emesonargs=(
		-Db_lto=false
		-Dplatforms="$(usex wayland 'wayland,x11' 'x11')"
		-Dgallium-drivers="swrast,zink"
		-Dgallium-extra-hud=false
  	 	-Dgallium-nine=false
  	-Dgallium-opencl=disabled
  	-Dgallium-va=disabled
		-Ddri3=disabled
	-Degl=disabled
  	-Dgallium-vdpau=disabled
	-Dgbm=enabled
		-Dllvm=enabled
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

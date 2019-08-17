# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/mesa/mesa.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="llvm"

DEPEND="dev-python/mako
	lib-sys/libunwind
	llvm? ( lib-sys/llvm )
	lib-media/libglvnd"

RDEPEND="
	>=lib-dev/expat-2.1.0-r3:=
	>=lib-sys/zlib-1.2.8
	>=x11-libs/libX11-1.6.2:=
	>=x11-libs/libxshmfence-1.1:=
	>=x11-libs/libXdamage-1.1.4-r1:=
	>=x11-libs/libXext-1.3.2:=
	>=x11-libs/libXxf86vm-1.1.3:=
	>=x11-libs/libxcb-1.9.3:=
	x11-libs/libXfixes:=
"

src_configure() {
	local emesonargs=(
		-Db_lto=false
		-Dplatforms=x11,drm,wayland
		-Ddri-drivers="i965,swrast"
		-Dgallium-drivers=""
		-Dswr-arches=avx,avx2
		-Ddri3=true
  		-Degl=true
		-Dgbm=true
		$(meson_use llvm)
	    -Dgles1=false
	    -Dgles2=true
	    -Dglvnd=true
	    -Dglx=dri
	    -Dshared-glapi=true
	    -Dtexture-float=true
		-Dvulkan-drivers="intel"
		-Dosmesa=classic
		-Dlibunwind=true
	    -Dlmsensors=false
    	-Dvalgrind=false
	)
	meson_src_configure
}


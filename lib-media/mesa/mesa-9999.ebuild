# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson multilib-minimal git-r3 flag-o-matic

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
KEYWORDS="amd64 arm64 x86"

EGIT_REPO_URI="https://anongit.freedesktop.org/git/mesa/mesa.git"
#EGIT_BRANCH=18.3

LICENSE="MIT"
SLOT="0"

DEPEND="dev-python/mako
		lib-sys/libunwind
		lib-sys/llvm
		lib-media/libglvnd"

RDEPEND="
	>=lib-dev/expat-2.1.0-r3:=[${MULTILIB_USEDEP}]
	>=lib-sys/zlib-1.2.8[${MULTILIB_USEDEP}]
	>=x11-libs/libX11-1.6.2:=[${MULTILIB_USEDEP}]
	>=x11-libs/libxshmfence-1.1:=[${MULTILIB_USEDEP}]
	>=x11-libs/libXdamage-1.1.4-r1:=[${MULTILIB_USEDEP}]
	>=x11-libs/libXext-1.3.2:=[${MULTILIB_USEDEP}]
	>=x11-libs/libXxf86vm-1.1.3:=[${MULTILIB_USEDEP}]
	>=x11-libs/libxcb-1.9.3:=[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:=[${MULTILIB_USEDEP}]
"

filter-flags -flto

src_configure() {
	local emesonargs=(
		-Db_lto=false
		-Dplatforms=x11,drm
		-Ddri-drivers="i965,swrast"
		-Dgallium-drivers=""
		-Dswr-arches=avx,avx2 
		-Ddri3=true 
  		-Degl=true 
		-Dgbm=true
		-Dllvm=true
    	-Dgles1=true
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

src_compile() {
	meson_src_compile
}

src_test() {
	meson_src_test
}

src_install() {
	meson_src_install
	rm -rf "${ED}"/usr/$(get_libdir)/libGLESv{1_CM,2}.so*
}

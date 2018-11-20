# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson multilib-minimal git-r3

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
KEYWORDS="amd64 arm64 x86"

EGIT_REPO_URI="https://anongit.freedesktop.org/git/mesa/mesa.git"
#EGIT_BRANCH=18.2

LICENSE="MIT"
SLOT="0"

IUSE="dri3 +egl gles1 gles2 unwind
	+nptl opencl osmesa openmax pic selinux vaapi valgrind
	llvm vulkan wayland xvmc xa"

REQUIRED_USE="
	gles1?  ( egl )
	gles2?  ( egl )
	wayland? ( egl )
"

DEPEND="dev-python/mako
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


src_configure() {
	local emesonargs=(
		-Db_lto=false
		-Dplatforms=x11
		$(meson_use dri3)
		-Ddri-drivers=swrast
		-Dgallium-drivers=""
		-Dllvm=false
		-Dgbm=true
    	-Dgles1=false
    	-Dgles2=false
    	-Dglvnd=true
    	-Dglx=dri
    	-Dshared-glapi=true
    	-Dtexture-float=true
		-Dgallium-xvmc=false
		-Dgallium-va=false
		-Dgallium-xa=false
		-Dvulkan-drivers=""
		-Dshader-cache=false
		-Dosmesa=classic
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
}

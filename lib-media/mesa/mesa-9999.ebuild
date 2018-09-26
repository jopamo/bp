# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_7 )

inherit meson multilib-minimal python-any-r1 git-r3

OPENGL_DIR="xorg-x11"

MY_P="${P/_/-}"

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
KEYWORDS="amd64 arm64 x86"

EGIT_REPO_URI="https://anongit.freedesktop.org/git/mesa/mesa.git"
#EGIT_BRANCH=18.2

LICENSE="MIT"
SLOT="0"

VIDEO_CARDS="freedreno i915 i965 imx intel nouveau vc4 virgl vivante vmware"
for card in ${VIDEO_CARDS}; do
	IUSE_VIDEO_CARDS+=" video_cards_${card}"
done

IUSE="${IUSE_VIDEO_CARDS}
	d3d9 debug dri3 +egl +gbm gles1 gles2 unwind
	+nptl opencl osmesa openmax pic selinux vaapi valgrind
	llvm vulkan wayland xvmc xa"

REQUIRED_USE="
	gles1?  ( egl )
	gles2?  ( egl )
	wayland? ( egl gbm )
"

LIBDRM_DEPSTRING=">=x11-libs/libdrm-2.4.89"
# keep correct libdrm and dri2proto dep
# keep blocks in rdepend for binpkg
RDEPEND="
	!<x11-app/xorg-server-1.7
	abi_x86_32? ( !app-misc/emul-linux-x86-opengl[-abi_x86_32(-)] )
	>=app-eselect/eselect-opengl-1.3.0
	>=lib-dev/expat-2.1.0-r3:=[${MULTILIB_USEDEP}]
	>=lib-sys/zlib-1.2.8[${MULTILIB_USEDEP}]
	>=x11-libs/libX11-1.6.2:=[${MULTILIB_USEDEP}]
	>=x11-libs/libxshmfence-1.1:=[${MULTILIB_USEDEP}]
	>=x11-libs/libXdamage-1.1.4-r1:=[${MULTILIB_USEDEP}]
	>=x11-libs/libXext-1.3.2:=[${MULTILIB_USEDEP}]
	>=x11-libs/libXxf86vm-1.1.3:=[${MULTILIB_USEDEP}]
	>=x11-libs/libxcb-1.9.3:=[${MULTILIB_USEDEP}]
	x11-libs/libXfixes:=[${MULTILIB_USEDEP}]
	unwind? ( lib-sys/libunwind[${MULTILIB_USEDEP}] )
	opencl? (
				app-eselect/eselect-opencl
				lib-dev/libclc
				virtual/libelf:0=[${MULTILIB_USEDEP}]
			)
	openmax? ( >=lib-media/libomxil-bellagio-0.9.3:=[${MULTILIB_USEDEP}] )
	vaapi? (
		>=x11-libs/libva-1.7.3:=[${MULTILIB_USEDEP}]
	)
	wayland? (
		>=lib-dev/wayland-1.11.0:=[${MULTILIB_USEDEP}]
		>=lib-dev/wayland-protocols-1.8
	)
	xvmc? ( >=x11-libs/libXvMC-1.0.8:=[${MULTILIB_USEDEP}] )

	video_cards_intel? (
		!video_cards_i965? ( ${LIBDRM_DEPSTRING}[video_cards_intel] )
	)
	video_cards_i915? ( ${LIBDRM_DEPSTRING}[video_cards_intel] )
"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	opencl? (
		>=sys-devel/gcc-4.6
	)
	sys-devel/gettext
	dev-util/pkgconfig
	valgrind? ( dev-util/valgrind )
	x11/xorgproto
	vulkan? (
		$(python_gen_any_dep ">=dev-python/mako-0.7.3[\${PYTHON_USEDEP}]")
	)
"
[[ ${PV} == *9999 ]] && DEPEND+="
	sys-devel/bison
	sys-devel/flex
	$(python_gen_any_dep ">=dev-python/mako-0.7.3[\${PYTHON_USEDEP}]")
"

QA_WX_LOAD="
x86? (
	!pic? (
		usr/lib*/libglapi.so.0.0.0
		usr/lib*/libGLESv1_CM.so.1.1.0
		usr/lib*/libGLESv2.so.2.0.0
		usr/lib*/libGL.so.1.2.0
		usr/lib*/libOSMesa.so.8.0.0
	)
)"

#PATCHES=( "${FILESDIR}/nvidia-meson.patch" )

src_configure() {
	local emesonargs=(
		-Dplatforms=x11
		$(meson_use dri3)
		-Ddri-drivers=swrast
		-Dgallium-drivers=""
		-Dgbm=true
		-Dllvm=false
		-Dgallium-xvmc=false
		-Dgallium-va=false
		-Dgallium-xa=false
		-Dvulkan-drivers=""
		-Dshader-cache=false
		-Dglx=dri
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

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-any-r1

DESCRIPTION="Reusable library for GPU-accelerated image processing primitives"
HOMEPAGE="

SNAPSHOT=7b29435072143ee8b7e131947e055d3780ae4e47
SRC_URI="https://github.com/haasn/libplacebo/archive/${SNAPSHOT}.tar.gz -> libplacebo-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libplacebo-${SNAPSHOT}"

	https://libplacebo.org/
	https://code.videolan.org/videolan/libplacebo/
"

LICENSE="
	LGPL-2.1+
	|| ( Apache-2.0 Boost-1.0 MIT )
	opengl? ( MIT )
"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+lcms llvm-libunwind +opengl +shaderc test unwind +vulkan +xxhash"
RESTRICT="!test? ( test )"
REQUIRED_USE="vulkan? ( shaderc )"

# dlopen: libglvnd (glad)
RDEPEND="
	lcms? ( xgui-misc/lcms )
	opengl? ( xmedia-live-lib/libglvnd )
	shaderc? ( xmedia-live-lib/shaderc )
	unwind? ( lib-live/libunwind )
	vulkan? ( xmedia-live-lib/vulkan-loader )
	xxhash? ( lib-live/xxhash )
"
# vulkan-headers is required even with USE=-vulkan (bug #882065)
DEPEND="
	${RDEPEND}
	app-dev/vulkan-headers
"
BDEPEND="
	$(python_gen_any_dep 'dev-python/jinja[${PYTHON_USEDEP}]')
	app-dev/pkgconf
"

python_check_deps() {
	python_has_version "dev-python/jinja[${PYTHON_USEDEP}]"
}

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		local EGIT_SUBMODULES=(
			3rdparty/fast_float
			$(usev opengl 3rdparty/glad)
		)
		git-r3_src_unpack
	else
		default

		rmdir "${S}"/3rdparty/fast_float || die
		mv fast_float-${FASTFLOAT_PV} "${S}"/3rdparty/fast_float || die

		if use opengl; then
			rmdir "${S}"/3rdparty/glad || die
			mv glad-${GLAD_PV} "${S}"/3rdparty/glad || die
		fi
	fi
}

src_prepare() {
	default

	# typically auto-skipped, but may assume usable opengl/vulkan then hang
	sed -i "/tests += 'opengl_surfaceless.c'/d" src/opengl/meson.build || die
	sed -i "/tests += 'vulkan.c'/d" src/vulkan/meson.build || die
}

multilib_src_configure() {
	local emesonargs=(
		-Ddemos=false #851927
		$(meson_use test tests)
		$(meson_feature lcms)
		-Dlibdovi=disabled # TODO: package libdovi, ask if you need this
		$(meson_feature opengl)
		$(meson_feature opengl gl-proc-addr)
		$(meson_feature shaderc)
		$(meson_feature unwind)
		$(meson_feature vulkan)
		$(meson_feature vulkan vk-proc-addr)
		-Dvulkan-registry="${ESYSROOT}"/usr/share/vulkan/registry/vk.xml
		$(meson_feature xxhash)
		-Dglslang=disabled
	)

	meson_src_configure
}

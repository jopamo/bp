# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-any-r1

DESCRIPTION="Reusable library for GPU-accelerated image processing primitives"
HOMEPAGE="https://libplacebo.org/"

SNAPSHOT=47ea18ef47875aafe611d47e07a6314ccc92a916
SRC_URI="https://github.com/haasn/libplacebo/archive/${SNAPSHOT}.tar.gz -> libplacebo-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libplacebo-${SNAPSHOT}"

LICENSE="
	LGPL-2.1+
	|| ( Apache-2.0 Boost-1.0 MIT )
	opengl? ( MIT )
"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+lcms llvm-libunwind opengl +shaderc test unwind +vulkan +xxhash"
RESTRICT="!test? ( test )"
REQUIRED_USE="vulkan? ( shaderc )"

# dlopen: libglvnd (glad)
RDEPEND="
	lcms? ( xgui-misc/lcms )
	opengl? ( xmedia-lib/libglvnd )
	shaderc? ( xmedia-lib/shaderc )
	unwind? ( lib-util/libunwind )
	vulkan? ( xmedia-lib/vulkan-loader )
	xxhash? ( lib-misc/xxhash )
"
# vulkan-headers is required even with USE=-vulkan (bug #882065)
DEPEND="
	${RDEPEND}
	xmedia-lib/glad
	app-dev/vulkan-headers
"
BDEPEND="
	$(python_gen_any_dep 'dev-python/jinja[${PYTHON_USEDEP}]')
	app-dev/pkgconf
"

python_check_deps() {
	python_has_version "dev-python/jinja[${PYTHON_USEDEP}]"
}

src_prepare() {
	default

	# typically auto-skipped, but may assume usable opengl/vulkan then hang
	sed -i "/tests += 'opengl_surfaceless.c'/d" src/opengl/meson.build || die
	sed -i "/tests += 'vulkan.c'/d" src/vulkan/meson.build || die
}

src_configure() {
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

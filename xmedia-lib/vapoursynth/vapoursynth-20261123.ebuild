# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 qa-policy
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end

DESCRIPTION="VapourSynth library for video manipulation"
HOMEPAGE="https://www.vapoursynth.com/"
SNAPSHOT=e7226aa818cb2dbad09241eac403fa981e01c497
GLSLANG_SNAPSHOT=6334e1549a49989e04b5329a6a39a328247fd6ed
VULKAN_HEADERS_SNAPSHOT=d277a0a3cda9c682708c93279f0c72cd6b0ae3f3
SRC_URI="
	https://github.com/vapoursynth/vapoursynth/archive/${SNAPSHOT}.tar.gz -> vapoursynth-${SNAPSHOT}.tar.gz
	https://github.com/KhronosGroup/glslang/archive/${GLSLANG_SNAPSHOT}.tar.gz -> glslang-${GLSLANG_SNAPSHOT}.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKAN_HEADERS_SNAPSHOT}.tar.gz -> Vulkan-Headers-${VULKAN_HEADERS_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/vapoursynth-${SNAPSHOT}"

LICENSE="LGPL-2.1 OFL-1.1 BSD-3 BSD-2 MIT Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="vspipe debug guard"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS} >=xgui-lib/zimg-3.0.5"
DEPEND="${RDEPEND}"
BDEPEND+="
	app-dev/pkgconf
	$(python_gen_cond_dep '>=dev-pypi/cython-3.3.0[${PYTHON_USEDEP}]')
"
PATCHES=( "${FILESDIR}/vapoursynth-resolve-core-library-path.patch" )

QA_POLICY_RPATH_ALLOW='^\$ORIGIN$'

distutils_enable_tests unittest

src_prepare() {
	distutils-r1_src_prepare
	local project source
	for project in glslang vulkan-headers; do
		case ${project} in
			glslang) source="${WORKDIR}/glslang-${GLSLANG_SNAPSHOT}" ;;
			vulkan-headers) source="${WORKDIR}/Vulkan-Headers-${VULKAN_HEADERS_SNAPSHOT}" ;;
		esac
		mv "${source}" "subprojects/${project}" || die
		cp -a "subprojects/packagefiles/${project}/." "subprojects/${project}/" || die
	done
}

python_configure_all() {
	qa-policy-configure
	DISTUTILS_ARGS=(
		-Dbuildtype=$(usex debug debug release)
		-Denable_guard_pattern=$(usex guard true false)
		-Ddefault_library=shared
	)
}

python_test() {
	"${EPYTHON}" -m unittest discover -v -s test -p '*test.py' || die "VapourSynth tests failed"
}

python_install() {
	distutils-r1_python_install
	local module_dir=$(python_get_sitedir)/vapoursynth
	local lib
	for lib in libvapoursynth.so libvapoursynth.so.4; do
		dosym -r "${module_dir}/libvapoursynth.so.4" "/usr/lib/${lib}"
	done
	dosym -r "${module_dir}/libvsscript.so" /usr/lib/libvapoursynth-script.so
	dosym -r "${module_dir}/libvsscript.so" /usr/lib/libvapoursynth-script.so.0
	dosym -r "${module_dir}/include" /usr/include/vapoursynth
	use vspipe || rm "${ED}/usr/bin/vspipe" || die

	local name directive macro version
	read -r directive macro version < VAPOURSYNTH_VERSION || die
	for name in vapoursynth vapoursynth-script; do
		cat > "${T}/${name}.pc" <<-PC || die
			prefix=${EPREFIX}/usr
			libdir=\${prefix}/lib
			includedir=\${prefix}/include/vapoursynth

			Name: ${name}
			Description: VapourSynth frameserver
			Version: ${version}
			Libs: -L\${libdir} -l${name}
			Cflags: -I\${includedir}
		PC
		insinto /usr/lib/pkgconfig
		doins "${T}/${name}.pc"
	done
}

python_install_all() {
	distutils-r1_python_install_all
	qa-policy-install
}

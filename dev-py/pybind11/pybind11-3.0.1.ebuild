# Distributed under the terms of the GNU General Public License v2

EAPI=8

# build via scikit-build-core PEP 517 backend
DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 cmake flag-o-matic

MY_P=${P/_}
DESCRIPTION="Seamless operability between C++11 and Python via lightweight bindings"
HOMEPAGE="
	https://pybind11.readthedocs.io/en/stable/
	https://github.com/pybind/pybind11/
	https://pypi.org/project/pybind11/
"
SRC_URI="
	https://github.com/pybind/pybind11/archive/v${PV/_}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# pybind11 is header-only at runtime, no hard runtime deps
# Eigen and friends are only needed for building and running upstream tests
RDEPEND=""

EPYTEST_PLUGINS=()
EPYTEST_RERUNS=5
EPYTEST_XDIST=1
distutils_enable_tests pytest

src_prepare() {
	filter-flags -Wl,-z,defs
	
	default
	cmake_src_prepare
}

python_compile() {
	# scikit-build-core >=0.10 rejects cmake.verbose, so unset it and use native CMake verbose if desired
	local -a skc=(
		--config-settings=cmake.verbose=
		--config-settings=cmake.define.HAS_FLTO=OFF
		--config-settings=cmake.define.PYBIND11_FINDPYTHON=OFF
		--config-settings=cmake.define.PYBIND11_INSTALL=ON
		--config-settings=cmake.define.PYBIND11_TEST=OFF
		--config-settings=cmake.define.prefix_for_pc_file="${EPREFIX}/usr"
		--config-settings=cmake.build-type=Release
	)
	distutils-r1_python_compile "${skc[@]}"

	# optionally build upstream C++ tests with plain CMake in a separate tree
	if use test; then
		local bdir="${BUILD_DIR}/cpptest"
		cmake -S "${S}" -B "${bdir}" \
			-DCMAKE_BUILD_TYPE=Release \
			-DPYBIND11_TEST=ON \
			-DPYBIND11_FINDPYTHON=ON \
			-DPYBIND11_INSTALL=OFF \
			-DHAS_FLTO=OFF \
			-Dprefix_for_pc_file="${EPREFIX}/usr" || die
		cmake --build "${bdir}" -j"$(get_makeopts_jobs)" || die
	fi
}

python_test() {
	# run upstream c++ tests if built
	if use test; then
		local bdir="${BUILD_DIR}/cpptest"
		ctest --test-dir "${bdir}" --output-on-failure -j"$(get_makeopts_jobs)" || die
	fi

	# run python-side tests under pytest
	epytest -q "${S}/tests"
}

python_install() {
	# wheel install provides headers, py module, and CMake config files
	distutils-r1_python_install
}

pkg_postinst() {
	elog "pybind11 headers are installed under \$(python -c 'import sysconfig;print(sysconfig.get_path(\"platinclude\"))')"
	elog "CMake consumers should use find_package(pybind11 CONFIG) and link against pybind11::headers"
}

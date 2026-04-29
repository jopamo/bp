# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/distro
	dev-pypi/packaging
	dev-pypi/setuptools
	dev-pypi/wheel
"
# lockstep-pypi-deps: end
DESCRIPTION="Improved build system generator for Python C/C++/Fortran/Cython extensions"
HOMEPAGE="
	https://github.com/scikit-build/scikit-build/
	https://pypi.org/project/scikit-build/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-pypi/distro[${PYTHON_USEDEP}]
	dev-pypi/packaging[${PYTHON_USEDEP}]
	>=dev-pypi/setuptools-42.0.0[${PYTHON_USEDEP}]
	>=dev-pypi/wheel-0.32.0[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-pypi/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		>=dev-pypi/build-0.7[${PYTHON_USEDEP}]
		>=dev-py/cython-0.25.1[${PYTHON_USEDEP}]
		dev-pypi/pip[${PYTHON_USEDEP}]
		dev-pypi/requests[${PYTHON_USEDEP}]
		dev-pypi/virtualenv[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs \
	dev-py/sphinx-rtd-theme \
	dev-py/sphinx-issues
# note: tests are unstable with xdist
EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

src_prepare() {
	local PATCHES=(
		# https://github.com/scikit-build/scikit-build/pull/1120
		"${FILESDIR}/${P}-setuptools-75.patch"
	)

	# not packaged
	sed -i -e '/cmakedomain/d' docs/conf.py || die
	distutils-r1_src_prepare
}

python_test() {

	local EPYTEST_DESELECT=(
		# Internet (via new setuptools?)
		tests/test_hello_cpp.py::test_hello_develop
	)

	# create a separate test tree since skbuild tests install random stuff
	cp -r "${BUILD_DIR}"/{install,test} || die
	local -x PATH=${BUILD_DIR}/test${EPREFIX}/usr/bin:${PATH}

	epytest -m "not isolated and not nosetuptoolsscm" \
		-o tmp_path_retention_count=1
}

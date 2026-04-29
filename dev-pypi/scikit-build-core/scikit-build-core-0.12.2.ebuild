# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/pathspec
"
# lockstep-pypi-deps: end
DESCRIPTION="Build backend for CMake based projects"
HOMEPAGE="
	https://github.com/scikit-build/scikit-build-core/
	https://pypi.org/project/scikit-build-core/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

# we always want [pyproject] extra
RDEPEND="
	app-dev/samurai
	app-dev/cmake
	>=dev-pypi/packaging-23.2[${PYTHON_USEDEP}]
	>=dev-pypi/pathspec-0.10.1[${PYTHON_USEDEP}]
	>=dev-pypi/pyproject-metadata-0.5[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-pypi/build[${PYTHON_USEDEP}]
		>=dev-py/cattrs-22.2.0[${PYTHON_USEDEP}]
		dev-pypi/fastjsonschema[${PYTHON_USEDEP}]
		dev-pypi/pybind11[${PYTHON_USEDEP}]
		>=dev-py/pytest-subprocess-1.5[${PYTHON_USEDEP}]
		dev-pypi/setuptools[${PYTHON_USEDEP}]
		dev-pypi/virtualenv[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-subprocess )
distutils_enable_tests pytest

python_test() {
	local _EPYTEST_DESELECT=(
		# TODO / we don't package validate_pyproject anyway
		tests/test_schema.py::test_compare_schemas
	)
	local EPYTEST_IGNORE=(
		# needs unpackaged validate_pyproject
		tests/test_schema.py
	)

	epytest -m "not isolated and not network"
}

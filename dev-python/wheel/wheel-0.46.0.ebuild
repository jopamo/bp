# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 8 -- sys-apps/portage dep
EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} python3_13t pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="A built-package format for Python"
HOMEPAGE="
	https://github.com/pypa/wheel/
	https://pypi.org/project/wheel/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/packaging-24.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-py/setuptools[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# fails if any setuptools plugin imported the module first
	tests/test_bdist_wheel.py::test_deprecated_import
)

distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}

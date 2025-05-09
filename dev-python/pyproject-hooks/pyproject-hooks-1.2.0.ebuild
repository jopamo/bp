# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} python3_13t pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Wrappers to build Python packages using PEP 517 hooks"
HOMEPAGE="
	https://pypi.org/project/pyproject-hooks/
	https://github.com/pypa/pyproject-hooks/
	https://pyproject-hooks.readthedocs.io/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		dev-python/testpath[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-python/tomli[${PYTHON_USEDEP}]
		' 3.10)
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# fails due to setuptools 70.1
	# https://bugs.gentoo.org/936052
	# https://github.com/pypa/pyproject-hooks/issues/203
	tests/test_call_hooks.py::test_setup_py
)

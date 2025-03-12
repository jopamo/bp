# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Python module to propose a modern general-purpose parsing library for Python"
HOMEPAGE="
	https://github.com/lark-parser/lark/
	https://pypi.org/project/lark/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# dev-python/regex doesn't support pypy
BDEPEND="
	test? (
		dev-python/atomicwrites[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-python/regex[${PYTHON_USEDEP}]
		' 'python*')
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_IGNORE=(
		# require dev-python/js2py which is a really bad quality package
		tests/test_nearley/test_nearley.py
	)

	epytest
}

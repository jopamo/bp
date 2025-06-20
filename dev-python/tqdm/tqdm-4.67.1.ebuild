# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Add a progress meter to your loops in a second"
HOMEPAGE="
	https://github.com/tqdm/tqdm/
	https://pypi.org/project/tqdm/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="examples"

BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-asyncio-0.24[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# Skip unpredictable performance tests
	tests/tests_perf.py
)

python_install_all() {
	doman tqdm/tqdm.1
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Plugin for pytest that automatically reruns flaky tests"
HOMEPAGE="
	https://github.com/box/flaky/
	https://pypi.org/project/flaky/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/genty[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

python_test() {
	epytest -k 'example and not options' --doctest-modules test/test_pytest/ || die
	epytest -p no:flaky test/test_pytest/test_flaky_pytest_plugin.py || die
	epytest --force-flaky --max-runs 2 test/test_pytest/test_pytest_options_example.py || die
}

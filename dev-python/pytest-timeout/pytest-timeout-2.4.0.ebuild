# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="pytest plugin to abort hanging tests"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-timeout/
	https://pypi.org/project/pytest-timeout/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# do not rdepend on pytest, it won't be used without it anyway
# pytest-cov used to test compatibility
BDEPEND="
	test? (
		dev-python/pexpect[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x PYTEST_PLUGINS=pytest_timeout

	if has_version "dev-python/pytest-cov[${PYTHON_USEDEP}]"; then
		PYTEST_PLUGINS+=,pytest_cov.plugin
	else
		EPYTEST_DESELECT+=(
			test_pytest_timeout.py::test_cov
		)
	fi

	epytest
}

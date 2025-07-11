# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_PN=${PN^}
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A Python package that generates fake data for you"
HOMEPAGE="
	https://github.com/joke2k/faker/
	https://pypi.org/project/Faker/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/tzdata[${PYTHON_USEDEP}]
	!dev-ruby/faker
"
BDEPEND="
	test? (
		dev-python/freezegun[${PYTHON_USEDEP}]
		xgui-app/pillow[${PYTHON_USEDEP},tiff]
		dev-python/validators[${PYTHON_USEDEP}]
	)
"

# note: tests are flaky with xdist
distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x PYTEST_PLUGINS=faker.contrib.pytest.plugin
	epytest
	epytest --exclusive-faker-session tests/pytest/session_overrides
}

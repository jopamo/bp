# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/aiofiles
	dev-pypi/blinker
	dev-pypi/click
	dev-pypi/flask
	dev-pypi/hypercorn
	dev-pypi/itsdangerous
	dev-pypi/jinja2
	dev-pypi/markupsafe
	dev-pypi/werkzeug
"
# lockstep-pypi-deps: end
DESCRIPTION="A Python ASGI web microframework with the same API as Flask"
HOMEPAGE="
	https://github.com/pallets/quart/
	https://pypi.org/project/Quart/
"
# no tests in sdist as of 0.20.0
SRC_URI="
	https://github.com/pallets/quart/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-py/aiofiles[${PYTHON_USEDEP}]
	>=dev-py/blinker-1.6[${PYTHON_USEDEP}]
	>=dev-py/click-8.0.0[${PYTHON_USEDEP}]
	>=dev-py/flask-3.0.0[${PYTHON_USEDEP}]
	>=dev-py/hypercorn-0.11.2[${PYTHON_USEDEP}]
	dev-py/itsdangerous[${PYTHON_USEDEP}]
	dev-py/jinja[${PYTHON_USEDEP}]
	dev-py/markupsafe[${PYTHON_USEDEP}]
	>=dev-py/werkzeug-3.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-py/hypothesis[${PYTHON_USEDEP}]
		dev-py/pytest-asyncio[${PYTHON_USEDEP}]
		dev-py/python-dotenv[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -o addopts= -p asyncio
}

# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/blinker
	dev-pypi/click
	dev-pypi/itsdangerous
	dev-pypi/jinja2
	dev-pypi/markupsafe
	dev-pypi/werkzeug
"
# lockstep-pypi-deps: end
DESCRIPTION="A microframework based on Werkzeug, Jinja2 and good intentions"
HOMEPAGE="
	https://palletsprojects.com/p/flask/
	https://github.com/pallets/flask/
	https://pypi.org/project/Flask/
"
if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/mitsuhiko/flask.git"
	inherit git-r3
else
	inherit pypi
	KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~mips ppc ppc64 ~riscv ~s390 ~sparc x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE="examples"

RDEPEND="
	>=dev-pypi/blinker-1.9[${PYTHON_USEDEP}]
	>=dev-pypi/click-8.1.3[${PYTHON_USEDEP}]
	>=dev-pypi/itsdangerous-2.2.0[${PYTHON_USEDEP}]
	>=dev-py/jinja-3.1.2[${PYTHON_USEDEP}]
	>=dev-pypi/werkzeug-3.1.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-pypi/asgiref-3.2[${PYTHON_USEDEP}]
		!!dev-py/shiboken2[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs \
	dev-py/pallets-sphinx-themes \
	dev-py/sphinx-issues \
	dev-py/sphinx-tabs \
	dev-py/sphinxcontrib-log-cabinet

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_install_all() {
	use examples && dodoc -r examples
	distutils-r1_python_install_all
}

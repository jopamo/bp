# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYPI_PN="CherryPy"
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cheroot
	dev-pypi/jaraco-collections
	dev-pypi/more-itertools
	dev-pypi/portend
	dev-pypi/zc-lockfile
"
# lockstep-pypi-deps: end
DESCRIPTION="CherryPy is a pythonic, object-oriented HTTP framework"
HOMEPAGE="
	https://cherrypy.dev/
	https://github.com/cherrypy/cherrypy/
	https://pypi.org/project/CherryPy/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="ssl test"

RDEPEND="
	>=dev-py/cheroot-8.2.1[${PYTHON_USEDEP}]
	>=dev-py/portend-2.1.1[${PYTHON_USEDEP}]
	dev-py/more-itertools[${PYTHON_USEDEP}]
	dev-py/zc-lockfile[${PYTHON_USEDEP}]
	dev-py/jaraco-collections[${PYTHON_USEDEP}]
	ssl? (
		dev-py/pyopenssl[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-py/routes[${PYTHON_USEDEP}]
		dev-py/simplejson[${PYTHON_USEDEP}]
		dev-py/objgraph[${PYTHON_USEDEP}]
		dev-py/path[${PYTHON_USEDEP}]
		dev-py/requests-toolbelt[${PYTHON_USEDEP}]
		
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i -e '/cov/d' pytest.ini || die
	# upstream has been using xfail to mark flaky tests, then added
	# xfail_strict... not a good idea
	sed -i -e '/xfail_strict/d' pytest.ini || die

	distutils-r1_python_prepare_all
}

python_test() {
	local EPYTEST_DESELECT=()
	local opts=()

	# These tests are gracefully skipped when pylibmc is missing but not
	# if pytest-services is missing -- even though that's the only test
	# using these fixtures.
	if ! has_version "dev-py/pytest-services[${PYTHON_USEDEP}]"; then
		EPYTEST_DESELECT+=(
			cherrypy/test/test_session.py::MemcachedSessionTest
		)
	else
		opts+=( -p pytest-services )
	fi

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest "${opts[@]}"
}

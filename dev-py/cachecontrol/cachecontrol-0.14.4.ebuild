# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
DISTUTILS_UPSTREAM_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/msgpack
	dev-pypi/requests
"
# lockstep-pypi-deps: end
DESCRIPTION="httplib2 caching for requests"
HOMEPAGE="
	https://pypi.org/project/CacheControl/
	https://github.com/psf/cachecontrol/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	<dev-py/msgpack-2[${PYTHON_USEDEP}]
	>=dev-py/msgpack-0.5.2[${PYTHON_USEDEP}]
	>=dev-py/requests-2.16.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-py/cherrypy[${PYTHON_USEDEP}]
		>=dev-py/filelock-3.8.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()

	if [[ ${EPYTHON} == pypy3* ]]; then
		EPYTEST_DESELECT+=(
			tests/test_adapter.py::TestSessionActions::test_do_not_leak_response
		)
	fi

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}

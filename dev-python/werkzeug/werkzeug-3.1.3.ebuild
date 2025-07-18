# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="
	https://palletsprojects.com/p/werkzeug/
	https://pypi.org/project/Werkzeug/
	https://github.com/pallets/werkzeug/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test-rust"

RDEPEND="
	>=dev-python/markupsafe-2.1.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/ephemeral-port-reserve[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		>=dev-python/pytest-xprocess-1[${PYTHON_USEDEP}]
		>=dev-python/watchdog-2.3[${PYTHON_USEDEP}]
		test-rust? (
			app-crypto/cryptography[${PYTHON_USEDEP}]
		)
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()
	if ! has_version "app-crypto/cryptography[${PYTHON_USEDEP}]"; then
		EPYTEST_DESELECT+=(
			"tests/test_serving.py::test_server[https]"
			tests/test_serving.py::test_ssl_dev_cert
			tests/test_serving.py::test_ssl_object
		)
	fi

	# the default portage tempdir is too long for AF_UNIX sockets
	local -x TMPDIR=/tmp
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p xprocess -p timeout tests
}

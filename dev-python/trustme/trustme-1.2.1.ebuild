# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="#1 quality TLS certs while you wait, for the discerning tester"
HOMEPAGE="
	https://github.com/python-trio/trustme/
	https://pypi.org/project/trustme/
"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=app-crypto/cryptography-3.1[${PYTHON_USEDEP}]
	>=dev-python/idna-2.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/service-identity[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_PN="PyJWT"
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="JSON Web Token implementation in Python"
HOMEPAGE="
	https://github.com/jpadilla/pyjwt/
	https://pypi.org/project/PyJWT/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	!dev-python/python-jwt
"
BDEPEND="
	test? (
		>=app-crypto/cryptography-3.4.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Internet
	tests/test_jwks_client.py::TestPyJWKClient::test_get_jwt_set_sslcontext_default
)

pkg_postinst() {
 "cryptography" app-crypto/cryptography
}

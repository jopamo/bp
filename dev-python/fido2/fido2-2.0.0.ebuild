# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Python based FIDO 2.0 library"
HOMEPAGE="
	https://github.com/Yubico/python-fido2/
	https://pypi.org/project/fido2/
"
SRC_URI="
	https://github.com/Yubico/python-fido2/releases/download/${PV}/${P}.tar.gz
"

LICENSE="Apache-2.0 BSD-2 MIT MPL-2.0"
SLOT="0/1.0" # Bumped every time a backwards-incompatible version is released
KEYWORDS="amd64 arm64"
IUSE="examples"

RDEPEND="
	app-crypto/cryptography[${PYTHON_USEDEP}]
	<dev-py/pyscard-3[${PYTHON_USEDEP}]
	examples? (
		dev-python/flask[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# unpin
	sed -i -e '/cryptography/s:, <[0-9]*::' pyproject.toml || die
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	# skip device integration tests
	epytest --no-device
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		docinto examples
		dodoc -r "${S}"/examples/.
		docompress -x "/usr/share/doc/${PF}/examples"
	fi
}

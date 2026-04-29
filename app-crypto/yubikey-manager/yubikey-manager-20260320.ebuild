# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=poetry

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/click
	dev-pypi/cryptography
	dev-pypi/fido2
	dev-pypi/keyring
	dev-pypi/pyscard
	dev-pypi/python-pskc
"
# lockstep-pypi-deps: end
MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library and command line tool for configuring a YubiKey"
HOMEPAGE="https://developers.yubico.com/yubikey-manager/"
SNAPSHOT=9fe76be2cbf5e9a3b5a9a8d78411949a028b3745
SRC_URI="https://github.com/Yubico/yubikey-manager/archive/${SNAPSHOT}.tar.gz -> yubikey-manager-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/yubikey-manager-${SNAPSHOT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ssl"

# app-crypt/ccid required for
# - 'ykman oath'
# - 'ykman openpgp'
# - 'ykman piv'
RDEPEND="
	app-crypto/ccid
	>=dev-py/click-8.0[${PYTHON_USEDEP}]
	app-crypto/cryptography[${PYTHON_USEDEP}]
	dev-py/fido2:0/1.0[${PYTHON_USEDEP}]
	dev-py/keyring[${PYTHON_USEDEP}]
	dev-py/pyscard[${PYTHON_USEDEP}]
	ssl? ( >=dev-py/pyopenssl-0.15.1[${PYTHON_USEDEP}] )"
BDEPEND="
	test? ( dev-py/makefun[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	doman man/ykman.1
}

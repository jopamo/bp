# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library and command line tool for configuring a YubiKey"
HOMEPAGE="https://developers.yubico.com/yubikey-manager/"
SNAPSHOT=29c3118714890406aed30ec1b6285b92c25742bd
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
	>=dev-python/click-8.0[${PYTHON_USEDEP}]
	app-crypto/cryptography[${PYTHON_USEDEP}]
	dev-python/fido2:0/1.0[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-py/pyscard[${PYTHON_USEDEP}]
	ssl? ( >=dev-python/pyopenssl-0.15.1[${PYTHON_USEDEP}] )"
BDEPEND="
	test? ( dev-python/makefun[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	doman man/ykman.1
}

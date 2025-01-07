# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry

inherit distutils-r1

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library and command line tool for configuring a YubiKey"
HOMEPAGE="https://developers.yubico.com/yubikey-manager/"
# According to https://github.com/Yubico/yubikey-manager/issues/518 the release
# tarballs on Yubico Web site and on GitHub should be identical, and at least
# for recent releases the latter are signed as well. Only the automatically
# generated "Source code (tar.gz)" tarballs should not be used.
# Still, prefer the former if available.
SRC_URI="https://developers.yubico.com/${PN}/Releases/${MY_P}.tar.gz
	verify-sig? ( https://developers.yubico.com/${PN}/Releases/${MY_P}.tar.gz.sig )"

S="${WORKDIR}"/${MY_P}

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

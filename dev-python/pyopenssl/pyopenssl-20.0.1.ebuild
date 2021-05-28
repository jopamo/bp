# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 flag-o-matic

MY_PN=pyOpenSSL
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python interface to the OpenSSL library"
HOMEPAGE="
	http://pyopenssl.sourceforge.net/
	https://launchpad.net/pyopenssl
	https://pypi.python.org/pypi/pyOpenSSL
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	>=dev-python/six-1.5.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_P}

python_prepare_all() {
	# Requires network access
	sed -i -e 's/test_set_default_verify_paths/_&/' tests/test_ssl.py || die
	distutils-r1_python_prepare_all
}

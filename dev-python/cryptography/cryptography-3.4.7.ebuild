# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 flag-o-matic

DESCRIPTION="Library providing cryptographic recipes and primitives"
HOMEPAGE="https://github.com/pyca/cryptography/ https://pypi.python.org/pypi/cryptography/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( Apache-2.0 BSD )"
SLOT="0"
#KEYWORDS="amd64 arm64"
#requires setuptools-rust

RDEPEND="
	virtual/ssl
	$(python_gen_cond_dep '>=dev-python/cffi-1.7:=[${PYTHON_USEDEP}]' 'python*')
	>=dev-python/idna-2.1[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-0.21.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	>=dev-python/setuptools-1.0[${PYTHON_USEDEP}]"

filter-flags -Wl,-z,defs

python_configure_all() {
	append-cflags $(test-flags-CC -pthread)
}

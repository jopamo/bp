# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="A self-contained cryptographic library for Python"
HOMEPAGE="https://www.pycryptodome.org https://github.com/Legrandin/pycryptodome https://pypi.org/project/pycryptodome/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2 Unlicense"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-dev/gmp:0
	dev-python/cffi[${PYTHON_USEDEP}]
	!dev-python/pycrypto"
DEPEND="${RDEPEND}"

python_test() {
	esetup.py test
}

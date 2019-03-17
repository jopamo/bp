# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

MY_PN="M2Crypto"

DESCRIPTION="M2Crypto: A Python crypto and SSL toolkit"
HOMEPAGE="https://gitlab.com/m2crypto/m2crypto"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"
S="${WORKDIR}/M2Crypto-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="swig"

RESTRICT=test

RDEPEND="
	lib-dev/openssl[-bindist(-)]
	dev-python/typing[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	swig? ( dev-lang/swig )
	dev-python/setuptools[${PYTHON_USEDEP}]
"

python_compile() {
	distutils-r1_python_compile --openssl="${EPREFIX}"/usr
}

python_test() {
	esetup.py test
}

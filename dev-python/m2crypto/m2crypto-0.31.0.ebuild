# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="M2Crypto: A Python crypto and SSL toolkit"
HOMEPAGE="https://gitlab.com/m2crypto/m2crypto"
SRC_URI="https://files.pythonhosted.org/packages/0a/d3/ecef6a0eaef77448deb6c9768af936fec71c0c4b42af983699cfa1499962/M2Crypto-${PV}.tar.gz"
S="${WORKDIR}/M2Crypto-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libressl swig"

RESTRICT=test

RDEPEND="
	!libressl? ( lib-dev/openssl[-bindist(-)] )
	libressl? ( lib-dev/libressl:0= )
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

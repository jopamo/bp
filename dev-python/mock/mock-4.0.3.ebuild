# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Rolling backport of unittest.mock for all Pythons"
HOMEPAGE="https://github.com/testing-cabal/mock"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

CDEPEND="
	>=dev-python/pbr-1.3[${PYTHON_USEDEP}]"
DEPEND=">=dev-python/setuptools-17.1[${PYTHON_USEDEP}]"
RDEPEND="
	${CDEPEND}
	>=dev-python/six-1.9[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all
}

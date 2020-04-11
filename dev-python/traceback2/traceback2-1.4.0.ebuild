# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Backports of the traceback module"
HOMEPAGE="https://github.com/testing-cabal/traceback2"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]"

RDEPEND="
	${DEPEND}
	dev-python/linecache2[${PYTHON_USEDEP}]"

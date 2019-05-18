# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="SOCKS client module"
HOMEPAGE="https://github.com/Anorov/PySocks http://pypi.python.org/pypi/PySocks"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="SOCKS client module"
HOMEPAGE="https://github.com/Anorov/PySocks http://pypi.python.org/pypi/PySocks"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

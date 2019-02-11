# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="World timezone definitions for Python"
HOMEPAGE="http://pythonhosted.org/pytz/ https://pypi.python.org/pypi/pytz/"
SRC_URI="https://files.pythonhosted.org/packages/cd/71/ae99fc3df1b1c5267d37ef2c51b7d79c44ba8a5e37b48e3ca93b4d74d98b/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	"${PYTHON}" pytz/tests/test_tzinfo.py -v || die "Tests fail with ${EPYTHON}"
}

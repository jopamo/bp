# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="World timezone definitions for Python"
HOMEPAGE="http://pythonhosted.org/pytz/ https://pypi.python.org/pypi/pytz/"
SRC_URI="https://files.pythonhosted.org/packages/ca/a9/62f96decb1e309d6300ebe7eee9acfd7bccaeedd693794437005b9067b44/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	"${PYTHON}" pytz/tests/test_tzinfo.py -v || die "Tests fail with ${EPYTHON}"
}

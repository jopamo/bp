# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Python 2 and 3 compatibility library"
HOMEPAGE="https://github.com/benjaminp/six https://pypi.python.org/pypi/six"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/pytest-2.2.0[${PYTHON_USEDEP}] )"

PATCHES=(
	"${FILESDIR}"/1.9.0-mapping.patch
)

python_test() {
	py.test -v || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
}

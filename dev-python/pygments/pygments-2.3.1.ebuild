# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

MY_PN="Pygments"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Pygments is a syntax highlighting package written in Python"
HOMEPAGE="http://pygments.org/ https://pypi.python.org/pypi/Pygments"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		fonts/liberation-fonts )"

S="${WORKDIR}/${MY_P}"

python_test() {
	cp -r -l tests "${BUILD_DIR}"/ || die
	# With pypy3 there is 1 error out of 1556 tests when run as is and
	# (SKIP=8, errors=1, failures=1) when run with 2to3; meh
	nosetests --verbosity=3 -w "${BUILD_DIR}"/tests \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
}

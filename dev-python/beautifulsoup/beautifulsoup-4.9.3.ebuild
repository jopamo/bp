# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

MY_PN=${PN}4
MY_P=${MY_PN}-${PV}

DESCRIPTION="Pythonic idioms for iterating, searching, and modifying an HTML/XML parse tree"
HOMEPAGE="https://www.crummy.com/software/BeautifulSoup/bs4/"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests --verbose -w "${BUILD_DIR}"/lib || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
}

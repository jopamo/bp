# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Collection of tools for internationalizing Python applications"
HOMEPAGE="http://babel.edgewall.org/ https://pypi.python.org/pypi/Babel"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${DEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Make the tests use implementation-specific datadir,
	# because they try to write in it.
	sed -e '/datadir =/s:os\.path\.dirname(__file__):os.environ["BUILD_DIR"]:' \
		-i tests/messages/test_frontend.py || die
	sed -e '/^intersphinx_mapping/,+3d' -i docs/conf.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	# Create implementation-specific datadir for tests.
	cp -R -l tests/messages/data "${BUILD_DIR}"/ || die
	py.test || die
}

# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Python documentation generator"
HOMEPAGE="http://www.sphinx-doc.org/"
SRC_URI="mirror://pypi/S/${PN^}/${P^}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="net"

RDEPEND="
	>=dev-python/alabaster-0.7.9[${PYTHON_USEDEP}]
	<dev-python/alabaster-0.8[${PYTHON_USEDEP}]
	>=dev-python/Babel-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.11[${PYTHON_USEDEP}]
	dev-python/imagesize[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.3[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.0.1-r1[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/six-1.5[${PYTHON_USEDEP}]
	>=dev-python/snowballstemmer-1.1[${PYTHON_USEDEP}]
	>=dev-python/sphinx_rtd_theme-0.1[${PYTHON_USEDEP}]
	<dev-python/sphinx_rtd_theme-2.0[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-websupport[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-qthelp[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-serializinghtml
	dev-python/sphinxcontrib-htmlhelp
	dev-python/packaging[${PYTHON_USEDEP}]
	net? (
		>=dev-python/sqlalchemy-0.9[${PYTHON_USEDEP}]
		>=dev-python/whoosh-2.0[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P^}"

python_prepare_all() {
	# remove tests that fail due to network-sandbox
	rm tests/test_build_linkcheck.py || die "Failed to remove web tests"

	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile

	# Generate the grammar. It will be caught by install somehow.
	# Note that the tests usually do it for us. However, I don't want
	# to trust USE=test really running all the tests, especially
	# with FEATURES=test-fail-continue.
	pushd "${BUILD_DIR}"/lib >/dev/null || die
	"${EPYTHON}" -m sphinx.pycode.__init__ || die "Grammar generation failed."
	popd >/dev/null || die
}

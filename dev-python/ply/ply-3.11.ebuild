# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit distutils-r1

DESCRIPTION="Python Lex-Yacc library"
HOMEPAGE="http://www.dabeaz.com/ply/ https://pypi.python.org/pypi/ply"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
IUSE="examples"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( ANNOUNCE CHANGES TODO )

PATCHES=( "${FILESDIR}/3.6-picklefile-IOError.patch" )

python_test() {
	cp -r -l test "${BUILD_DIR}"/ || die
	cd "${BUILD_DIR}"/test || die

	# Checks for pyc/pyo files
	local -x PYTHONDONTWRITEBYTECODE=

	local t
	for t in testlex.py testyacc.py; do
		"${PYTHON}" "${t}" || die "${t} fails with ${EPYTHON}"
	done
}

python_install_all() {
	local HTML_DOCS=( doc/. )
	use examples && dodoc -r example
	distutils-r1_python_install_all
}

# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python Documentation Utilities"
HOMEPAGE="http://docutils.sourceforge.net/ https://pypi.python.org/pypi/docutils"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD-2 GPL-3 public-domain"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

DEPEND="dev-python/pygments[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_compile_all() {
	# Generate html docs from reStructured text sources.

	# Place html4css1.css in base directory to ensure that the generated reference to it is correct.
	cp docutils/writers/html4css1/html4css1.css . || die

	cd tools || die
	"${EPYTHON}" buildhtml.py --input-encoding=utf-8 \
		--stylesheet-path=../html4css1.css, --traceback ../docs || die
}

python_test() {
	if python_is_python3; then
		pushd test3 > /dev/null || die
	else
		pushd test > /dev/null || die
	fi
	"${EPYTHON}" alltests.py || die "Testing failed with ${EPYTHON}"
	popd > /dev/null || die
}

python_install() {
	distutils-r1_python_install

	# Install tools.
	python_doscript tools/{buildhtml,quicktest}.py
}

python_install_all() {
	distutils-r1_python_install_all
}

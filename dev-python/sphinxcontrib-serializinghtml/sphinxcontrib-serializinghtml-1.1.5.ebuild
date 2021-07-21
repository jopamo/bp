# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Sphinx extension which outputs outputs serialized HTML files"
HOMEPAGE="https://www.sphinx-doc.org
	https://github.com/sphinx-doc/sphinxcontrib-serializinghtml"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="dev-python/namespace-sphinxcontrib[${PYTHON_USEDEP}]"
PDEPEND="
	>=dev-python/sphinx-2.0[${PYTHON_USEDEP}]"
BDEPEND="
	test? ( ${PDEPEND} )"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}

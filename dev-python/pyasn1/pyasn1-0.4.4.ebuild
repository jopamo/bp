# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="ASN.1 library for Python"
HOMEPAGE="http://snmplabs.com/pyasn1/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="doc"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_test() {
	esetup.py test || die "Tests fail with ${EPYTHON}"
}

src_compile() {
	if use doc; then
		python_setup
		esetup.py build_sphinx
	fi
	distutils-r1_src_compile
}

src_install() {
	local HTML_DOCS
	use doc && HTML_DOCS=( build/sphinx/html/. )

	distutils-r1_src_install
}

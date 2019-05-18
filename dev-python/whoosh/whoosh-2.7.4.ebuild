# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Fast, pure-Python full text indexing, search and spell checking library"
HOMEPAGE="https://bitbucket.org/mchaput/whoosh/wiki/Home/ https://pypi.python.org/pypi/Whoosh/"
SRC_URI="mirror://pypi/W/${PN^}/${P^}.tar.gz"

LICENSE="BSD-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${P^}"

PATCHES=(
	"${FILESDIR}"/${PN}-2.7.4-tests-specify-utf8.patch
)

python_prepare_all() {
	# (backport from upstream)
	sed -i -e '/cmdclass/s:pytest:PyTest:' setup.py || die

	# Prevent un-needed download during build
	sed -e "/^              'sphinx.ext.intersphinx',/d" -i docs/source/conf.py || die

	distutils-r1_python_prepare_all
}


python_test() {
	esetup.py test
}

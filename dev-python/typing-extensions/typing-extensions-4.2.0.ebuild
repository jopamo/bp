# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit

inherit distutils-r1

MY_P=typing-${PV}
DESCRIPTION="Backported and Experimental Type Hints for Python 3.7+"
HOMEPAGE="
	https://pypi.org/project/typing-extensions/
	https://github.com/python/typing/
"
SRC_URI="
	https://github.com/python/typing/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}/typing_extensions

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"

python_test() {
	cd "${S}"/src || die
	"${EPYTHON}" test_typing_extensions.py -v || die "tests failed under ${EPYTHON}"
}

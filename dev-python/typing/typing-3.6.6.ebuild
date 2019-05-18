# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit distutils-r1

DESCRIPTION="Type Hints for Python"
HOMEPAGE="https://docs.python.org/3/library/typing.html https://pypi.python.org/pypi/typing"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	if [[ ${EPYTHON} == python2* || ${EPYTHON} == pypy ]]; then
		cd "${S}"/python2 || die
	else
		cd "${S}"/src || die
	fi

	"${PYTHON}" test_typing.py || die "tests failed under ${EPYTHON}"
}

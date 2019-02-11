# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

MY_PN="MarkupSafe"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implements a XML/HTML/XHTML Markup safe string for Python"
HOMEPAGE="https://pypi.python.org/pypi/MarkupSafe"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

S=${WORKDIR}/${MY_P}
DISTUTILS_IN_SOURCE_BUILD=1

python_compile() {
	distutils-r1_python_compile
	if [[ ${EPYTHON} == python3.2 ]]; then
		2to3 --no-diffs -n -w -f unicode ${PN} || die
	fi
}

python_test() {
	esetup.py test
}

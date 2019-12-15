# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 flag-o-matic

MY_PN=${PN/-/.}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Interfaces for Python"
HOMEPAGE="https://pypi.org/project/zope.interface/ https://github.com/zopefoundation/zope.interface"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0/1"
KEYWORDS="amd64 arm64"
IUSE="test"


RDEPEND="
	dev-python/namespace-zope[${PYTHON_USEDEP}]"

DEPEND="
	${RDEPEND}
	>=dev-python/setuptools-33.1.1[${PYTHON_USEDEP}]
	test? ( dev-python/zope-event[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_compile() {
	if ! python_is_python3; then
		local CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
		append-flags -fno-strict-aliasing
	fi

	distutils-r1_python_compile
}

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all

	# remove .pth files since dev-python/namespace-zope handles the ns
	find "${D}" -name '*.pth' -delete || die
}

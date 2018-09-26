# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1
MY_PN=zope.event

MY_P=${MY_PN}-${PV}
DESCRIPTION="Event publishing / dispatch, used by Zope Component Architecture"
HOMEPAGE="https://github.com/zopefoundation/zope.event http://docs.zope.org/zope.event/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND="dev-python/namespace-zope[${PYTHON_USEDEP}]"
DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_P}

python_test() {
	nosetests || die
}

python_install_all() {
	distutils-r1_python_install_all

	# remove .pth files since dev-python/namespace-zope handles the ns
	find "${D}" -name '*.pth' -delete || die
}

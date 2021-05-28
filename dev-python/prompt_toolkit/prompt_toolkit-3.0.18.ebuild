# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Building powerful interactive command lines in Python"
HOMEPAGE="https://pypi.org/project/prompt_toolkit/ https://github.com/jonathanslenders/python-prompt-toolkit"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test || die
}

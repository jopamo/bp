# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="ANSI escape character sequences for colored terminal text & cursor positioning"
HOMEPAGE="https://pypi.org/project/colorama/"
SRC_URI="https://github.com/tartley/${PN}/archive/${PV}.tar.gz -> ${P}.github.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

python_test() {
	script -eqc "pytest -vv -s" /dev/null \
		|| die "tests failed with ${EPYTHON}"
}

# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Python module for spawning child apps and responding to expected patterns"
HOMEPAGE="https://pexpect.readthedocs.io/ https://pypi.org/project/pexpect/ https://github.com/pexpect/pexpect/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND=">=dev-python/ptyprocess-0.5[${PYTHON_USEDEP}]"
DEPEND="
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	pytest -vv tests || die "Tests fail with ${EPYTHON}"
}

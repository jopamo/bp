# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Parse human-readable date/time strings"
HOMEPAGE="https://github.com/bear/parsedatetime"
SRC_URI="https://github.com/bear/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="dev-python/future[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare() {
	rm setup.cfg || die
}

python_test() {
	py.test || die
}

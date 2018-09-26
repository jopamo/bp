# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Universal encoding detector"
HOMEPAGE="https://github.com/chardet/chardet https://pypi.python.org/pypi/chardet"
SRC_URI="https://github.com/chardet/chardet/archive/${PV}.tar.gz -> ${P}.tar.gz"

# SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
# PyPI tarball is missing test.py: https://github.com/chardet/chardet/pull/118

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}

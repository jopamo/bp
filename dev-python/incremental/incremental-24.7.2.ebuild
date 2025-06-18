# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Incremental is a small library that versions your Python projects"
HOMEPAGE="
	https://github.com/twisted/incremental/
	https://pypi.org/project/incremental/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-py/setuptools-61.0[${PYTHON_USEDEP}]
"
# note: most of test deps are for examples that we can't run without
# Internet
BDEPEND="
	${RDEPEND}
	test? (
		dev-python/twisted[${PYTHON_USEDEP}]
	)
"
RDEPEND+="
	>=dev-python/click-6.0[${PYTHON_USEDEP}]
"

python_test() {
	"${EPYTHON}" -m twisted.trial incremental ||
		die "Tests failed on ${EPYTHON}"
}

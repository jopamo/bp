# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="An XML Schema validator and decoder"
HOMEPAGE="
	https://github.com/sissaschool/xmlschema/
	https://pypi.org/project/xmlschema/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	<dev-python/elementpath-6[${PYTHON_USEDEP}]
	>=dev-python/elementpath-4.8.0[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-py/setuptools-77[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-py/jinja[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
	)
"

python_test() {
	"${EPYTHON}" tests/run_all_tests.py -v || die "Tests fail with ${EPYTHON}"
}

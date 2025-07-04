# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Better dates and times for Python"
HOMEPAGE="
	https://github.com/arrow-py/arrow/
	https://pypi.org/project/arrow/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/python-dateutil-2.7.0[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	sed -i -e '/addopts/d' tox.ini || die
	# unnecessary type stub deps
	sed -i -e '/types-/d' pyproject.toml || die
	distutils-r1_src_prepare
}

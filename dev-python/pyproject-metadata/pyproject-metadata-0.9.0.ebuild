# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="PEP 621 metadata parsing"
HOMEPAGE="
	https://github.com/pypa/pyproject-metadata/
	https://pypi.org/project/pyproject-metadata/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/packaging-19[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			>=dev-python/tomli-1.0.0[${PYTHON_USEDEP}]
		' 3.10)
	)
"

distutils_enable_tests pytest

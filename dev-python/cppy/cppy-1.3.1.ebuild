# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="C++ header library which makes it easier to write Python extension modules"
HOMEPAGE="
	https://github.com/nucleic/cppy/
	https://pypi.org/project/cppy/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-py/setuptools-61.2[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
"

distutils_enable_tests pytest

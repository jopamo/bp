# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A tool for resolving PEP 735 Dependency Group data"
HOMEPAGE="
	https://github.com/pypa/dependency-groups/
	https://pypi.org/project/dependency-groups/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

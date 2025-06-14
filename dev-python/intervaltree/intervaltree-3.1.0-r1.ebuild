# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Editable interval tree data structure for Python 2 and 3"
HOMEPAGE="
	https://github.com/chaimleib/intervaltree/
	https://pypi.org/project/intervaltree/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

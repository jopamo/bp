# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Plugin and hook calling mechanisms for Python"
HOMEPAGE="
	https://pluggy.readthedocs.io/
	https://github.com/pytest-dev/pluggy/
	https://pypi.org/project/pluggy/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

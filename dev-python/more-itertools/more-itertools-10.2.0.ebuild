# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="More routines for operating on iterables, beyond itertools"
HOMEPAGE="
	https://github.com/more-itertools/more-itertools/
	https://pypi.org/project/more-itertools/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme
distutils_enable_tests unittest

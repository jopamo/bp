# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="library with cross-python path, ini-parsing, io, code, log facilities"
HOMEPAGE="
	https://py.readthedocs.io/
	https://github.com/pytest-dev/py/
	https://pypi.org/project/py/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
# This package is unmaintained and keeps being broken periodically.
RESTRICT=test

BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

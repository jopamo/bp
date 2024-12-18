# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Rolling backport of unittest.mock for all Pythons"
HOMEPAGE="
	https://github.com/testing-cabal/mock/
	https://pypi.org/project/mock/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest

DOCS=( CHANGELOG.rst README.rst )

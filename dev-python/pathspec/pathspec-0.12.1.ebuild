# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} python3_13t pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Utility library for gitignore style pattern matching of file paths"
HOMEPAGE="
	https://github.com/cpburnz/python-pathspec/
	https://pypi.org/project/pathspec/
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests unittest

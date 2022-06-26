# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Utility library for gitignore style pattern matching of file paths"
HOMEPAGE="
	https://github.com/cpburnz/python-path-specification/
	https://pypi.org/project/pathspec/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests unittest

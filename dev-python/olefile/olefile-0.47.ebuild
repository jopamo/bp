# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="Python package to parse, read and write Microsoft OLE2 files"
HOMEPAGE="
	https://www.decalage.info/olefile/
	https://github.com/decalage2/olefile/
	https://pypi.org/project/olefile/
"
SRC_URI="
	https://github.com/decalage2/olefile/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_sphinx doc \
	dev-python/sphinx-rtd-theme
distutils_enable_tests unittest

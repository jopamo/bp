# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A pure Python implementation of a sliding window memory map manager"
HOMEPAGE="
	https://pypi.org/project/smmap/
	https://github.com/gitpython-developers/smmap/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests unittest

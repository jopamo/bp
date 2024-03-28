# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Backported and Experimental Type Hints for Python 3.7+"
HOMEPAGE="
	https://pypi.org/project/typing-extensions/
	https://github.com/python/typing_extensions/
"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests unittest

python_test() {
	cd src || die
	eunittest
}

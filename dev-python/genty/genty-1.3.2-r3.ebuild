# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Allows you to run a test with multiple data sets"
HOMEPAGE="
	https://pypi.org/project/genty/
	https://github.com/box/genty/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

src_prepare() {
	distutils-r1_src_prepare
	sed -i -e 's:from mock:from unittest.mock:' test/test_genty.py || die
}

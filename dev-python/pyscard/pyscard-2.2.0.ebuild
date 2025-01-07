# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 

DESCRIPTION="Smart card support in python"
HOMEPAGE="
	https://pyscard.sourceforge.io/
	https://github.com/LudovicRousseau/pyscard/
	https://pypi.org/project/pyscard/
"
SRC_URI="
	https://downloads.sourceforge.net/project/pyscard/pyscard/pyscard%20${PV}/${P}.tar.gz
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-crypto/pcsc-lite
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	app-lang/swig
"

distutils_enable_tests pytest

pkg_postinst() {
	filter-flags -Wl,-z,defs
 "Gui support" dev-python/wxpython
 "Support of remote readers with Pyro" dev-python/Pyro4
}

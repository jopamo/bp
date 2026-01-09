# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 flag-o-matic

DESCRIPTION="Smart card support in python"
HOMEPAGE="https://github.com/LudovicRousseau/pyscard/"
SNAPSHOT=e1f2a5fe6ffc4f327576e96a887fa9c46883bc50
SRC_URI="https://github.com/LudovicRousseau/pyscard/archive/${SNAPSHOT}.tar.gz -> pyscard-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pyscard-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-crypto/pcsc-lite"
BDEPEND="app-lang/swig"

distutils_enable_tests pytest

filter-flags -Wl,-z,defs

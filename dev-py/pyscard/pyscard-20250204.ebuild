# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 flag-o-matic

DESCRIPTION="Smart card support in python"
HOMEPAGE="https://github.com/LudovicRousseau/pyscard/"

SNAPSHOT=4d72f9dd22c99ca26af428a9a8e62b69bba1a09d
SRC_URI="https://github.com/LudovicRousseau/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-crypto/pcsc-lite"
BDEPEND="app-lang/swig"

distutils_enable_tests pytest

filter-flags -Wl,-z,defs

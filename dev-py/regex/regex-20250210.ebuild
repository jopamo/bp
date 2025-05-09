# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi flag-o-matic

DESCRIPTION="Alternative regular expression module to replace re"
HOMEPAGE="
	https://github.com/mrabarnett/mrab-regex/
	https://pypi.org/project/regex/
"

SNAPSHOT=be75782535bd817bc3fa18f8e9d875366340ead7
SRC_URI="https://github.com/mrabarnett/mrab-regex/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/mrab-${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests unittest

src_prepare() {
	filter-flags -Wl,-z,defs
	default
}

# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi flag-o-matic

DESCRIPTION="Alternative regular expression module to replace re"
HOMEPAGE="https://github.com/mrabarnett/mrab-regex/"
SNAPSHOT=5d51c75da03116e08bb6fb537fae6d8c804cc92c
SRC_URI="https://github.com/mrabarnett/mrab-regex/archive/${SNAPSHOT}.tar.gz -> regex-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/mrab-regex-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests unittest

src_prepare() {
	filter-flags -Wl,-z,defs
	default
}

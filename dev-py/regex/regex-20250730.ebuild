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
SNAPSHOT=23ca191dd8d259a42bc3dcae092e4eafce48652d
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

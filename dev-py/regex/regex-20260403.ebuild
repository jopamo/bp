# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi flag-o-matic
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Alternative regular expression module to replace re"
HOMEPAGE="https://github.com/mrabarnett/mrab-regex/"
SNAPSHOT=bc57b04b00de68590345ac2eb621b9a8dd222d7d
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

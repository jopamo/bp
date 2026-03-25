# Distributed under the terms of the GNU General Public License v2

inherit cmake distutils-r1 flag-o-matic

DISTUTILS_EXT=1

BRANCH_NAME="v$(ver_cut 1)"

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
SNAPSHOT=0bd647456e57ae17796937b9f296ef8bc1201b9e
SRC_URI="https://github.com/capstone-engine/capstone/archive/${SNAPSHOT}.tar.gz -> capstone-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/capstone-${SNAPSHOT}"

EGIT_BRANCH="next"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="diet python debug"

src_prepare() {
	append-flags -Wno-error
	filter-flags -Wall
	filter-flags -Wl,-z,defs -flto*
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"

	default
	use python && cd bindings/python && distutils-r1_src_prepare
}

src_configure() {
	default
	use python && cd bindings/python && distutils-r1_src_configure
}

src_compile() {
	default
	use python && cd bindings/python && distutils-r1_src_compile
}

python_test() {
	cd bindings/python && esetup.py test || die
}

src_test() {
	default
	use python && cd bindings/python && distutils-r1_src_test
}

src_install() {
	default
	use python && cd bindings/python && distutils-r1_src_install
}

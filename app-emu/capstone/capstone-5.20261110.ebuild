# Distributed under the terms of the GNU General Public License v2

inherit cmake distutils-r1 flag-o-matic
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end
DISTUTILS_EXT=1

BRANCH_NAME="v$(ver_cut 1)"

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
SNAPSHOT=1549a0e927a6e77c4f9e4ed07e872a3c0a1ee754
SRC_URI="https://github.com/capstone-engine/capstone/archive/${SNAPSHOT}.tar.gz -> capstone-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/capstone-${SNAPSHOT}"

EGIT_BRANCH="next"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="diet python debug"

PATCHES=( "${FILESDIR}/capstone-python-test-status.patch" )

src_prepare() {
	append-flags -Wno-error
	filter-flags -Wall
	filter-flags -Wl,-z,defs -flto*
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"

	default
	local PATCHES=()
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
	"${EPYTHON}" tests/test_all.py || die "Python binding tests failed"
}

src_test() {
	default
	use python && cd bindings/python && distutils-r1_src_test
}

src_install() {
	default
	use python && cd bindings/python && distutils-r1_src_install
}

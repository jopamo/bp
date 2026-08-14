# Distributed under the terms of the GNU General Public License v2

inherit cmake distutils-r1 flag-o-matic
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end
DESCRIPTION="Keystone assembler framework"
HOMEPAGE="https://github.com/keystone-engine/keystone"

SNAPSHOT=0d9567f08c0c23e8f604b2cad3d49450c93cfb40
SRC_URI="https://github.com/keystone-engine/keystone/archive/${SNAPSHOT}.tar.gz -> keystone-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/keystone-${SNAPSHOT}"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python"

filter-flags -flto\*

src_prepare() {
	cmake_src_prepare
	use python && cd bindings/python && distutils-r1_src_prepare
}

src_configure() {
	cmake_src_configure
	use python && cd bindings/python && distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	use python && cd bindings/python && distutils-r1_src_compile
}

python_test() {
	cd bindings/python || die
	"${EPYTHON}" - <<-'PY' || die "Keystone Python binding smoke test failed"
	from keystone import KS_ARCH_X86, KS_MODE_64, Ks

	encoding, count = Ks(KS_ARCH_X86, KS_MODE_64).asm("nop; ret")
	assert encoding == [0x90, 0xc3], encoding
	assert count == 2, count
	PY
}

src_test() {
	cmake_src_test
	use python && cd bindings/python && distutils-r1_src_test
}

src_install() {
	cmake_src_install
	use python && cd bindings/python && distutils-r1_src_install
}

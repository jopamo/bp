# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake distutils-r1 flag-o-matic

DISTUTILS_EXT=1

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
SNAPSHOT=95a4ca3ee680bacc421d95b99d587235873c950d
SRC_URI="https://github.com/capstone-engine/capstone/archive/${SNAPSHOT}.tar.gz -> capstone-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/capstone-${SNAPSHOT}"

EGIT_BRANCH="next"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+diet +python debug"

src_prepare() {
	append-flags -Wno-error
	filter-flags -Wl,-z,defs -flto*
	cmake_src_prepare
	use python && cd bindings/python && distutils-r1_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCAPSTONE_BUILD_DIET="$(usex diet)"
		-DCAPSTONE_BUILD_STATIC_LIBS=ON
		-DCAPSTONE_INSTALL=ON
		-DCAPSTONE_ARCHITECTURE_DEFAULT=OFF
		-DCAPSTONE_ARM64_SUPPORT=ON
		-DCAPSTONE_X86_SUPPORT=ON
	)
	cmake_src_configure
	use python && cd bindings/python && distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	use python && cd bindings/python && distutils-r1_src_compile
}

python_test() {
	cd bindings/python && esetup.py test || die
}

src_test() {
	cmake_src_test
	use python && cd bindings/python && distutils-r1_src_test
}

src_install() {
	cmake_src_install
	use python && cd bindings/python && distutils-r1_src_install
}

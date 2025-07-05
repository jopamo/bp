# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="llvm_release_$(ver_cut 1)0"

inherit cmake flag-o-matic multiprocessing

DESCRIPTION="Bi-directional translator between SPIR-V and LLVM IR"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-LLVM-Translator"

SNAPSHOT=6a96a625abea08b953c02b53dabf1586dbca5569
SRC_URI="https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/${SNAPSHOT}.tar.gz -> spirv-llvm-translator-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SPIRV-LLVM-Translator-${SNAPSHOT}"

LICENSE="UoI-NCSA"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64 ~loong ~riscv ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-dev/spirv-tools
	app-build/llvm
"
DEPEND="${RDEPEND}
	app-dev/spirv-headers
"
BDEPEND="app-dev/pkgconf"

PATCHES=(
)

src_prepare() {
	replace-flags -Os -O2

	filter-clang
	cmake_src_prepare

	# https://github.com/KhronosGroup/SPIRV-LLVM-Translator/pull/2555
	sed -i -e 's/%triple/x86_64-unknown-linux-gnu/' test/DebugInfo/X86/*.ll || die
}

src_configure() {
	local -x CC="clang"
       local -x CPP="clang-cpp"
       local -x CXX="clang++"
       local -x AR="llvm-ar"
       local -x NM="llvm-nm"
       local -x RANLIB="llvm-ranlib"

	local mycmakeargs=(
		-DCCACHE_ALLOWED="OFF"
		-DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR="${ESYSROOT}/usr/include/spirv"
		-DLLVM_SPIRV_INCLUDE_TESTS=$(usex test "ON" "OFF")
		-DCLANG_DEFAULT_LINKER=ld.lld
        -DCMAKE_AR=llvm-ar
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER="clang++"
        -DCMAKE_NM=llvm-nm
        -DCMAKE_RANLIB=llvm-ranlib
		-Wno-dev
	)

	cmake_src_configure
}


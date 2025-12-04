# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="llvm_release_$(ver_cut 1)0"

inherit cmake flag-o-matic multiprocessing

DESCRIPTION="Bi-directional translator between SPIR-V and LLVM IR"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-LLVM-Translator"
SNAPSHOT=a79c852b36785588032a2dd7c39aa15ec4d24b20
SRC_URI="https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/${SNAPSHOT}.tar.gz -> spirv-llvm-translator-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SPIRV-LLVM-Translator-${SNAPSHOT}"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="amd64 arm64"

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
	local mycmakeargs=(
		-DCCACHE_ALLOWED="OFF"
		-DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR="${ESYSROOT}/usr/include/spirv"
		-DLLVM_SPIRV_INCLUDE_TESTS=$(usex test "ON" "OFF")
		-Wno-dev
	)

	cmake_src_configure
}


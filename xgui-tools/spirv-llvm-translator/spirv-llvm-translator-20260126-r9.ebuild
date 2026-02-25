# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="llvm_release_$(ver_cut 1)0"

inherit cmake flag-o-matic

DESCRIPTION="Bi-directional translator between SPIR-V and LLVM IR"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-LLVM-Translator"
SNAPSHOT=60fa4bf33e0deef8c115f1c8bea807b203989446
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

	# derive LLVM version from the system clang
	local sys_llvm_ver sys_llvm_ver_num
	sys_llvm_ver="$(
		clang --version | sed -n 's/^clang version \([^ ]\+\).*/\1/p' | head -n1
	)"
	[[ -n "${sys_llvm_ver}" ]] || die "failed to parse clang version"

	# numeric only (strip -rc1, -git, etc) -> 22.1.0
	sys_llvm_ver_num="$(printf '%s' "${sys_llvm_ver}" | sed -e 's/[-+].*$//')"
	[[ "${sys_llvm_ver_num}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || die "bad numeric clang version: ${sys_llvm_ver_num}"

	# BASE_LLVM_VERSION drives find_package(LLVM <ver> ...)
	sed -i \
		-e "s/^[[:space:]]*set[[:space:]]*(BASE_LLVM_VERSION[[:space:]]\+[^ )]\+[[:space:]]*)/  set (BASE_LLVM_VERSION ${sys_llvm_ver_num})/" \
		CMakeLists.txt || die

	# if the project() VERSION is derived from BASE_LLVM_VERSION, force it numeric too
	sed -i \
		-e "s/^\([[:space:]]*project([^)]*VERSION[[:space:]]\+\)[^ )]\+\(.*\)$/\1${sys_llvm_ver_num}\2/" \
		CMakeLists.txt || die

	# fix LLVM DIBuilder API mismatch
	# DIBuilder::createSubroutineType wants DITypeRefArray on newer LLVM
	sed -i \
		-e 's/^[[:space:]]*DITypeArray[[:space:]]\+ArgTypes[[:space:]]*=[[:space:]]*getDIBuilder(DebugInst)\.getOrCreateTypeArray(Elements);/  auto ArgTypes = getDIBuilder(DebugInst).getOrCreateTypeArray(Elements);/' \
		lib/SPIRV/SPIRVToLLVMDbgTran.cpp || die

	# fix LLVM DISubroutineType::getTypeArray API mismatch
	# getTypeArray returns DITypeRefArray on newer LLVM
	sed -i \
		-e 's/^[[:space:]]*DITypeArray[[:space:]]\+Types[[:space:]]*=[[:space:]]*FT->getTypeArray();/  auto Types = FT->getTypeArray();/' \
		lib/SPIRV/LLVMToSPIRVDbgTran.cpp || die

	# https://github.com/KhronosGroup/SPIRV-LLVM-Translator/pull/2555
	sed -i -e 's/%triple/x86_64-unknown-linux-gnu/' test/DebugInfo/X86/*.ll || die
}

src_configure() {
	local mycmakeargs=(
		-DCCACHE_ALLOWED="OFF"

		# Force the *system* LLVM package
		-DLLVM_DIR="${ESYSROOT}/usr/lib/cmake/llvm"

		#-DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR="${ESYSROOT}/usr/include/spirv"
		-DLLVM_SPIRV_INCLUDE_TESTS=$(usex test "ON" "OFF")
		-Wno-dev
	)

	cmake_src_configure
}

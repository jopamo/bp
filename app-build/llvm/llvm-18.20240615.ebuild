# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

if [[ ${PV} == 18* ]] ; then
	SNAPSHOT="3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff"

elif [[ ${PV} == 13* ]] ; then
	SNAPSHOT="75e33f71c2dae584b13a7d1186ae0a038ba98838"

elif [[ ${PV} == 14* ]] ; then
	SNAPSHOT="f28c006a5895fc0e329fe15fead81e37457cb1d1"

elif [[ ${PV} == 15* ]] ; then
	SNAPSHOT="8dfdcc7b7bf66834a761bd8de445840ef68e4d1a"

elif [[ ${PV} == 16* ]] ; then
	SNAPSHOT="7cbf1a2591520c2491aa35339f227775f4d3adf6"

elif [[ ${PV} == 17* ]] ; then
	SNAPSHOT="6009708b4367171ccdbf4b5905cb6a803753fe18"

elif [[ ${PV} == 12* ]] ; then
	SNAPSHOT="fed41342a82f5a3a9201819a82bf7a48313e296b"
fi

SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/llvm"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="amdgpu arm bpf bootstrap +debug nvptx stage1 stage2 test wasm xcore"

DEPEND="
	lib-core/libffi
	lib-core/libxml2
	virtual/curses
"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

PATCHES=(
	"${FILESDIR}/0001-InstSimplify-Fix-simplifyAndOrWithICmpEq-with-undef-.patch"
	"${FILESDIR}/0002-ConstantFold-Fix-result-type-when-folding-powi.f16-9.patch"
	"${FILESDIR}/0003-Fix-assertion-failure-in-PR98681-98860.patch"
	"${FILESDIR}/0004-SDAG-Intersect-poison-generating-flags-after-CSE-974.patch"
	"${FILESDIR}/0005-InstCombine-Guard-noundef-for-transformation-from-xo.patch"
	"${FILESDIR}/0006-ARM-Fix-arm32be-softfp-mode-miscompilation-for-neon-.patch"
	"${FILESDIR}/0007-AArch64-Avoid-overflow-when-using-shl-lower-mul-9714.patch"
	"${FILESDIR}/0008-X86-matchAddressRecursively-ensure-dead-nodes-are-re.patch"
	"${FILESDIR}/0009-X86-matchAddressRecursively-don-t-fold-zext-shl-x-c-.patch"
	"${FILESDIR}/0010-SelectionDAG-use-HandleSDNode-instead-of-SDValue-dur.patch"
	"${FILESDIR}/0011-InstCombine-Add-test-for-97053-NFC.patch"
	"${FILESDIR}/0012-InstCombine-Fix-invalid-scalarization-of-div.patch"
	"${FILESDIR}/0013-ADT-Add-cstdint-to-SmallVector-101761.patch"
	"${FILESDIR}/0014-AMDGPU-Include-cstdint-in-AMDGPUMCTargetDesc-101766.patch"
	"${FILESDIR}/0015-Another-gcc-15-fix-from-Sam-James.patch"
	"${FILESDIR}/0016-llvm-exegesis-Use-correct-rseq-struct-size-100804.patch"
	"${FILESDIR}/0020-SDAG-Honor-signed-arguments-in-floating-point-libcal.patch"
)

src_prepare() {
	cmake_src_prepare
	sed -i '/#include <string>/a #include <cstdint>' "include/llvm/Support/Signals.h" || die
}

src_configure() {
	replace-flags -O3 -O2

	strip-flags
	filter-lto
	append-flags -fpic

	local LLVM_TARGETS=""

	case "${CHOST}" in
		*aarch64*) LLVM_TARGETS+="AArch64" ;;
		*x86_64*)  LLVM_TARGETS+="X86" ;;
		*)		  die "Unsupported host architecture: ${CHOST}" ;;
	esac

	use amdgpu && LLVM_TARGETS+=";AMDGPU"
	use arm && LLVM_TARGETS+=";ARM"
	use bpf && LLVM_TARGETS+=";BPF"
	use nvptx && LLVM_TARGETS+=";NVPTX"
	use wasm && LLVM_TARGETS+=";WebAssembly"
	use xcore && LLVM_TARGETS+=";XCore"

	echo "Selected LLVM targets: ${LLVM_TARGETS}"

	local common_all=(
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_CXX_COMPILER_WORKS=1
		-DCMAKE_CXX_STANDARD=17
		-DCMAKE_C_COMPILER_WORKS=1
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DLLVM_APPEND_VC_REV=OFF
		-DLLVM_BINUTILS_INCDIR="${EPREFIX}"/usr/include
		-DLLVM_BUILD_DOCS=OFF
		-DLLVM_BUILD_LLVM_DYLIB=ON
		-DLLVM_BUILD_TESTS=$(usex test)
		-DLLVM_ENABLE_ASSERTIONS=$(usex debug)
		-DLLVM_ENABLE_CUDA=OFF
		-DLLVM_ENABLE_DOXYGEN=OFF
		-DLLVM_ENABLE_EH=ON
		-DLLVM_ENABLE_FFI=ON
		-DLLVM_ENABLE_LIBPFM=OFF
		-DLLVM_ENABLE_LIBXML2=ON
		-DLLVM_ENABLE_OCAMLDOC=OFF
		-DLLVM_ENABLE_RTTI=ON
		-DLLVM_INCLUDE_TESTS=OFF
		-DLLVM_ENABLE_SPHINX=OFF
		-DLLVM_ENABLE_TERMINFO=ON
		-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="${LLVM_TARGETS}"
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DLLVM_INSTALL_UTILS=ON
		-DLLVM_LINK_LLVM_DYLIB=ON
		-DLLVM_TARGETS_TO_BUILD=""
		-DOCAMLFIND=NO
		-DLLVM_OPTIMIZED_TABLEGEN=ON
		-DLLVM_PARALLEL_LINK_JOBS=1
		-DLLVM_ENABLE_ZLIB=FORCE_ON
		-DLLVM_ENABLE_ZSTD=FORCE_ON
		-DCMAKE_CXX_COMPILER_TARGET="${CHOST}"
	)

	local stage1=(
		-DLLVM_ENABLE_RUNTIMES=""
		-DBOOTSTRAP_BOOTSTRAP_LLVM_ENABLE_LLD=ON
		-DBOOTSTRAP_LLVM_ENABLE_LLD=ON
		-DCLANG_BOOTSTRAP_PASSTHROUGH="CMAKE_INSTALL_PREFIX;CMAKE_VERBOSE_MAKEFILE"
		-DCLANG_ENABLE_BOOTSTRAP=ON
		-DLLVM_ENABLE_PROJECTS="llvm;clang;lld"
		-DBOOTSTRAP_LLVM_ENABLE_LTO=ON
	)

	local common_stage2_3=(
		-DCMAKE_AR="llvm-ar"
		-DCMAKE_RANLIB="llvm-ranlib"
		-DCOMPILER_RT_BUILD_LIBFUZZER=OFF
		-DCOMPILER_RT_BUILD_MEMPROF=OFF
		-DCOMPILER_RT_BUILD_ORC=OFF
		-DCOMPILER_RT_BUILD_PROFILE=OFF
		-DCOMPILER_RT_BUILD_SANITIZERS=OFF
		-DCOMPILER_RT_BUILD_XRAY=OFF
		-DCOMPILER_RT_USE_LIBEXECINFO=OFF
		-DLIBCXXABI_ENABLE_SHARED=ON
		-DLIBCXXABI_ENABLE_STATIC=ON
		-DLIBCXXABI_INCLUDE_TESTS=OFF
		-DLIBCXXABI_LIBUNWIND_INCLUDES="${EPREFIX}"/usr/include
		-DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=OFF
		-DLIBCXX_ENABLE_SHARED=ON
		-DLIBCXX_ENABLE_STATIC=ON
		-DLIBCXX_HAS_MUSL_LIBC=$(usex elibc_musl)
		-DLIBCPP_HAS_MUSL_LIBC=$(usex elibc_musl)
		-DLIBCXX_INCLUDE_BENCHMARKS=OFF
		-DLIBCXX_INCLUDE_TESTS=OFF
		-DLIBCXX_LIBDIR_SUFFIX=
		-DLIBUNWIND_ENABLE_ASSERTIONS=$(usex debug)
		-DLIBUNWIND_ENABLE_CROSS_UNWINDING=ON
		-DLIBUNWIND_ENABLE_STATIC=ON
		-DLIBUNWIND_INCLUDE_TESTS=OFF
		-DLIBUNWIND_INSTALL_HEADERS=ON
		-DLLVM_BUILD_LLVM_DYLIB=ON
		-DLLVM_ENABLE_LTO="Thin"
		-DLLVM_ENABLE_PROJECTS="llvm;clang;lld"
		-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt"
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DLLVM_LINK_LLVM_DYLIB=ON
		-DLLVM_USE_LINKER="/usr/bin/ld.lld"
	)

	local stage2=(
		-DLIBCXXABI_USE_LLVM_UNWINDER=OFF
	)

	local stage3=(
		-DLIBCXXABI_USE_COMPILER_RT=ON
		-DLIBCXXABI_USE_LLVM_UNWINDER=ON
		-DLIBCXX_CXX_ABI=system-libcxxabi
		-DLIBCXX_HAS_GCC_S_LIB=OFF
		-DLIBCXX_USE_COMPILER_RT=ON
		-DLIBUNWIND_USE_COMPILER_RT=ON
		-DLLVM_ENABLE_LIBCXX=ON
	)

	if use stage2 || ! use stage1; then
		local -x CC=clang
		local -x CXX=clang++
		local -x CC="clang"
		local -x CPP="clang-cpp"
		local -x CXX="clang++"
		local -x AR="llvm-ar"
		local -x NM="llvm-nm"
		local -x RANLIB="llvm-ranlib"

		local -x LLVM_FLTO="-flto=thin"
		local -x LLVM_FLAGS="-fuse-ld=lld"
		local -x LLVM_PASSFLAGS="${OPTIMIZE} ${LLVM_FLAGS} ${BASEFLAGS} ${LLVM_FLTO} ${SECURE}"
		local -x CFLAGS="${MARCH} ${LLVM_PASSFLAGS}"
		local -x LDFLAGS="-Wl,${LLVM_PASSFLAGS} -Wl,-z,combreloc -Wl,-z,defs -Wl,-z,now -Wl,-z,relro -Wl,-O1"
	fi

	if use stage1; then
		mycmakeargs+=("${common_all[@]}" "${stage1[@]}")
	elif use stage2; then
		mycmakeargs+=("${common_all[@]}" "${common_stage2_3[@]}" "${stage2[@]}")
	else
		mycmakeargs+=("${common_all[@]}" "${common_stage2_3[@]}" "${stage3[@]}")
	fi

	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"
	cmake_src_configure
}

src_test() {
	local -x LIT_PRESERVES_TMP=1
	cmake_src_make check
}

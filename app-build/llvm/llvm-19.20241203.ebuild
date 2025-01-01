# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

if [[ ${PV} == 19* ]] ; then
	SNAPSHOT="ab4b5a2db582958af1ee308a790cfdb42bd24720"

elif [[ ${PV} == 18* ]] ; then
	SNAPSHOT="3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff"

elif [[ ${PV} == 17* ]] ; then
	SNAPSHOT="6009708b4367171ccdbf4b5905cb6a803753fe18"

elif [[ ${PV} == 16* ]] ; then
	SNAPSHOT="7cbf1a2591520c2491aa35339f227775f4d3adf6"

elif [[ ${PV} == 15* ]] ; then
	SNAPSHOT="8dfdcc7b7bf66834a761bd8de445840ef68e4d1a"

elif [[ ${PV} == 14* ]] ; then
	SNAPSHOT="f28c006a5895fc0e329fe15fead81e37457cb1d1"

elif [[ ${PV} == 13* ]] ; then
	SNAPSHOT="75e33f71c2dae584b13a7d1186ae0a038ba98838"

elif [[ ${PV} == 12* ]] ; then
	SNAPSHOT="fed41342a82f5a3a9201819a82bf7a48313e296b"
fi

SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/llvm"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="amdgpu arm +bpf bootstrap debug late nvptx bootstrap stage test wasm xcore"

DEPEND="
	lib-core/libffi
	lib-core/libxml2
	virtual/curses
"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

PATCHES=(
#	"${FILESDIR}/0002-ConstantFold-Fix-result-type-when-folding-powi.f16-9.patch"
)

src_prepare() {
	cmake_src_prepare
	sed -i '/#include <string>/a #include <cstdint>' "include/llvm/Support/Signals.h" || die
}

src_configure() {
	replace-flags -O3 -O2

	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -D_GLIBCXX_ASSERTIONS
	filter-flags -Wl,-z,combreloc
	filter-flags -Wl,-z,defs
	filter-flags -Wl,-z,now
	filter-flags -Wl,-z,relro
	filter-flags -flto*
	filter-flags -fstack-clash-protection
	filter-flags -fstack-protector-strong

	strip-flags

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

	local common=(
		-DBUILD_SHARED_LIBS=OFF
		-DCLANG_DEFAULT_OPENMP_RUNTIME=libomp
		-DCLANG_DEFAULT_PIE_ON_LINUX=ON
		-DCLANG_ENABLE_ARCMT=OFF
		-DCLANG_ENABLE_LIBXML2=ON
		-DCLANG_ENABLE_STATIC_ANALYZER=OFF
		-DCLANG_INCLUDE_TESTS=OFF
		-DCLANG_LINK_CLANG_DYLIB=ON
		-DCMAKE_CXX_COMPILER_WORKS=1
		-DCMAKE_CXX_STANDARD=17
		-DCMAKE_C_COMPILER_WORKS=1
		-DCMAKE_DISABLE_FIND_PACKAGE_CUDAToolkit=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_hsa-runtime64=ON
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DLIBCPP_HAS_MUSL_LIBC=$(usex elibc_musl)
		-DLIBCXXABI_ENABLE_SHARED=ON
		-DLIBCXXABI_ENABLE_STATIC=ON
		-DLIBCXXABI_INCLUDE_TESTS=OFF
		-DLIBCXXABI_LIBUNWIND_INCLUDES="${EPREFIX}"/usr/include
		-DLIBCXXABI_USE_LLVM_UNWINDER=OFF
		-DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=OFF
		-DLIBCXX_ENABLE_SHARED=ON
		-DLIBCXX_ENABLE_STATIC=ON
		-DLIBCXX_HAS_MUSL_LIBC=$(usex elibc_musl)
		-DLIBCXX_INCLUDE_BENCHMARKS=OFF
		-DLIBCXX_INCLUDE_TESTS=OFF
		-DLIBCXX_LIBDIR_SUFFIX=
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
		-DLLVM_ENABLE_PROJECTS="llvm;clang;lld"
		-DLLVM_ENABLE_RTTI=ON
		-DLLVM_ENABLE_SPHINX=OFF
		-DLLVM_ENABLE_TERMINFO=ON
		-DLLVM_ENABLE_ZLIB=FORCE_ON
		-DLLVM_ENABLE_ZSTD=FORCE_ON
		-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="${LLVM_TARGETS}"
		-DLLVM_INCLUDE_TESTS=OFF
		-DLLVM_INSTALL_UTILS=ON
		-DLLVM_LINK_LLVM_DYLIB=ON
		-DLLVM_PARALLEL_LINK_JOBS=1
		-DLLVM_TARGETS_TO_BUILD=""
		-DOCAMLFIND=NO
	)

	local bootstrap=(
		-DBOOTSTRAP_BOOTSTRAP_LLVM_ENABLE_LLD=ON
		-DBOOTSTRAP_LLVM_ENABLE_LLD=ON
		-DBOOTSTRAP_LLVM_ENABLE_LTO=ON
		-DCLANG_BOOTSTRAP_PASSTHROUGH="CMAKE_INSTALL_PREFIX;CMAKE_VERBOSE_MAKEFILE"
		-DCLANG_ENABLE_BOOTSTRAP=ON
		-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi"
	)

	local late=(
		-DLIBUNWIND_ENABLE_ASSERTIONS=$(usex debug)
		-DLIBUNWIND_ENABLE_CROSS_UNWINDING=ON
		-DLIBUNWIND_ENABLE_STATIC=ON
		-DLIBUNWIND_INCLUDE_TESTS=OFF
		-DLIBUNWIND_INSTALL_HEADERS=ON
		-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind"
		-DLLVM_OPTIMIZED_TABLEGEN=ON
		-DLIBCXXABI_USE_COMPILER_RT=OFF
		-DLIBCXX_HAS_GCC_S_LIB=OFF
		-DLIBCXX_USE_COMPILER_RT=OFF
		-DLIBUNWIND_USE_COMPILER_RT=OFF
		-DLLVM_ENABLE_LIBCXX=OFF
	)

	local last=(
		-DCOMPILER_RT_BUILD_LIBFUZZER=OFF
		-DCOMPILER_RT_BUILD_MEMPROF=OFF
		-DCOMPILER_RT_BUILD_ORC=ON
		-DCOMPILER_RT_BUILD_PROFILE=OFF
		-DCOMPILER_RT_BUILD_SANITIZERS=OFF
		-DCOMPILER_RT_BUILD_XRAY=OFF
		-DCOMPILER_RT_USE_LIBEXECINFO=OFF
		-DLIBUNWIND_ENABLE_ASSERTIONS=$(usex debug)
		-DLIBUNWIND_ENABLE_CROSS_UNWINDING=ON
		-DLIBUNWIND_ENABLE_STATIC=ON
		-DLIBUNWIND_INCLUDE_TESTS=OFF
		-DLIBUNWIND_INSTALL_HEADERS=ON
		-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt"
		-DLLVM_OPTIMIZED_TABLEGEN=ON
		-DLIBCXXABI_USE_COMPILER_RT=OFF
		-DLIBCXX_CXX_ABI=libcxxabi
		-DLIBCXX_HAS_GCC_S_LIB=OFF
		-DLIBCXX_USE_COMPILER_RT=OFF
		-DLIBUNWIND_USE_COMPILER_RT=OFF
		-DLLVM_ENABLE_LIBCXX=OFF
	)

	#if ! use bootstrap && ! use late; then
	#	local -x CC=clang
	#	local -x CXX=clang++
	#	local -x CC="clang"
	#	local -x CPP="clang-cpp"
	#	local -x CXX="clang++"
	#	local -x AR="llvm-ar"
	#	local -x NM="llvm-nm"
	#	local -x RANLIB="llvm-ranlib"
	#fi

	if use bootstrap; then
		mycmakeargs+=("${common[@]}" "${bootstrap[@]}")
	elif use late; then
		mycmakeargs+=("${common[@]}" "${bootstrap[@]}" "${late[@]}")
	else
		mycmakeargs+=("${common[@]}" "${bootstrap[@]}" "${late[@]}")
	fi

	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"
	cmake_src_configure
}

src_test() {
	local -x LIT_PRESERVES_TMP=1
	cmake_src_make check
}

src_install() {
	cmake_src_install

	if ! use bootstrap; then
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++.a" "/usr/lib/libc++.a"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++.so" "/usr/lib/libc++.so"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++.so.1" "/usr/lib/libc++.so"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++.so.1.0" "/usr/lib/libc++.so.1"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++abi.a" "/usr/lib/libc++abi.a"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++abi.so" "/usr/lib/libc++abi.so"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++abi.so.1" "/usr/lib/libc++abi.so"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++abi.so.1.0" "/usr/lib/libc++abi.so.1"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libc++experimental.a" "/usr/lib/libc++experimental.a"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libunwind.a" "/usr/lib/libunwind.a"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libunwind.so" "/usr/lib/libunwind.so"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libunwind.so.1" "/usr/lib/libunwind.so"
		dosym -r "/usr/lib/x86_64-unknown-linux-gnu/libunwind.so.1.0" "/usr/lib/libunwind.so.1"
	fi
}

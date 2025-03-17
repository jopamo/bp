# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

SNAPSHOT="cd708029e0b2869e80abe31ddb175f7c35361f90"
SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/llvm"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="amdgpu arm bpf bootstrap debug stage2 nvptx bootstrap stage test wasm xcore"

DEPEND="
    lib-core/libffi
    lib-core/libxml2
    virtual/curses
"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

PATCHES=(
#   "${FILESDIR}/0002-ConstantFold-Fix-result-type-when-folding-powi.f16-9.patch"
)

src_prepare() {
    cmake_src_prepare
    sed -i '/#include <string>/a #include <cstdint>' "include/llvm/Support/Signals.h" || die
}

src_configure() {
    # link to compiler-rt
    local use_compiler_rt=OFF
    [[ $(tc-get-c-rtlib) == compiler-rt ]] && use_compiler_rt=ON

    # bootstrap: cmake is unhappy if compiler can't link to stdlib
    local nolib_flags=( -nodefaultlibs -lc )
    if ! test_compiler; then
        if test_compiler "${nolib_flags[@]}"; then
            local -x LDFLAGS="${LDFLAGS} ${nolib_flags[*]}"
            ewarn "${CXX} seems to lack runtime, trying with ${nolib_flags[*]}"
        fi
    fi

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
        *)        die "Unsupported host architecture: ${CHOST}" ;;
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
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DCMAKE_CXX_STANDARD=17
        -DCMAKE_DISABLE_FIND_PACKAGE_CUDAToolkit=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_hsa-runtime64=ON
        -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
        -DLIBCPP_HAS_MUSL_LIBC=$(usex elibc_musl)
        -DLIBCXX_ENABLE_SHARED=ON
        -DLIBCXX_ENABLE_STATIC=ON
        -DLIBCXX_HAS_GCC_S_LIB=OFF
        -DLIBCXX_HAS_MUSL_LIBC=$(usex elibc_musl)
        -DLIBCXX_INCLUDE_BENCHMARKS=OFF
        -DLIBCXX_INCLUDE_TESTS=OFF
        -DLIBCXX_LIBDIR_SUFFIX=
        -DLIBCXXABI_ENABLE_SHARED=ON
        -DLIBCXXABI_ENABLE_STATIC=ON
        -DLIBCXXABI_INCLUDE_TESTS=OFF
        -DLIBCXXABI_LIBUNWIND_INCLUDES="${EPREFIX}"/usr/include
        -DLIBCXXABI_USE_LLVM_UNWINDER=OFF
        -DLLVM_APPEND_VC_REV=OFF
        -DLLVM_BUILD_DOCS=OFF
        -DLLVM_BUILD_LLVM_DYLIB=ON
        -DLLVM_BUILD_TESTS=$(usex test)
        -DLLVM_ENABLE_ASSERTIONS=ON
        -DLLVM_ENABLE_CUDA=OFF
        -DLLVM_ENABLE_DOXYGEN=OFF
        -DLLVM_ENABLE_EH=ON
        -DLLVM_ENABLE_FFI=ON
        -DLLVM_ENABLE_LIBPFM=OFF
        -DLLVM_ENABLE_OCAMLDOC=OFF
        -DLLVM_ENABLE_RTTI=ON
        -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt"
        -DLLVM_ENABLE_SPHINX=OFF
        -DLLVM_ENABLE_TERMINFO=ON
        -DLLVM_ENABLE_ZLIB=FORCE_ON
        -DLLVM_ENABLE_ZSTD=FORCE_ON
        -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="${LLVM_TARGETS}"
        -DLLVM_INCLUDE_BENCHMARKS=OFF
        -DLLVM_INCLUDE_TESTS=OFF
        -DLLVM_INSTALL_UTILS=ON
        #-DLLVM_LIBGCC_EXPLICIT_OPT_IN=Yes
        -DLLVM_LINK_LLVM_DYLIB=ON
        -DLLVM_PARALLEL_LINK_JOBS=1
        -DLLVM_TARGETS_TO_BUILD=""
        -DOCAMLFIND=NO
        -DLLVM_ENABLE_PROJECTS="llvm;clang;lld"
        -DCMAKE_SKIP_BUILD_RPATH=TRUE
        -DCMAKE_BUILD_WITH_INSTALL_RPATH=FALSE
        -DCMAKE_INSTALL_RPATH=""
        -DNO_INSTALL_RPATH=ON
    )

    local bootstrap=(
        -DBOOTSTRAP_BOOTSTRAP_LLVM_ENABLE_LLD=ON
        -DBOOTSTRAP_LLVM_ENABLE_LLD=ON
        -DBOOTSTRAP_LLVM_ENABLE_LTO=ON
        -DCLANG_BOOTSTRAP_PASSTHROUGH="CMAKE_INSTALL_PREFIX;CMAKE_VERBOSE_MAKEFILE"
        -DCLANG_ENABLE_BOOTSTRAP=ON
        -DLLVM_ENABLE_LIBEDIT=OFF
        -DLLVM_ENABLE_LIBXML2=OFF
        -DLLVM_ENABLE_LLD=OFF
    )

    local stage2=(
        -DCOMPILER_RT_BUILD_LIBFUZZER=OFF
        -DCOMPILER_RT_BUILD_MEMPROF=OFF
        -DCOMPILER_RT_BUILD_ORC=ON
        -DCOMPILER_RT_BUILD_PROFILE=OFF
        -DCOMPILER_RT_BUILD_SANITIZERS=ON
        -DCOMPILER_RT_BUILD_XRAY=OFF
        -DCOMPILER_RT_CXX_LIBRARY=libcxx
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON
        -DCOMPILER_RT_USE_LIBEXECINFO=OFF
        -DLIBCXX_CXX_ABI_INCLUDE_PATHS="${EPREFIX}/usr/include/c++/v1"
        -DLIBCXX_CXX_ABI=libcxxabi
        -DLIBCXX_ENABLE_ASSERTIONS=ON
        -DLIBCXX_ENABLE_LOCALIZATION=ON
        -DLIBCXX_ENABLE_NEW_DELETE_DEFINITIONS=ON
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=ON
        -DLIBCXX_USE_COMPILER_RT=ON
        -DLIBCXXABI_ENABLE_STATIC_UNWINDER=ON
        -DLIBCXXABI_USE_COMPILER_RT=ON
        -DLIBUNWIND_ENABLE_ASSERTIONS=ON
        -DLIBUNWIND_ENABLE_CROSS_UNWINDING=ON
        -DLIBUNWIND_ENABLE_SHARED=OFF
        -DLIBUNWIND_ENABLE_STATIC=ON
        -DLIBUNWIND_INCLUDE_TESTS=OFF
        -DLIBUNWIND_INSTALL_HEADERS=ON
        -DLIBUNWIND_SUPPORTS_FNO_EXCEPTIONS_FLAG=OFF
        -DLIBUNWIND_SUPPORTS_FUNWIND_TABLES_FLAG=OFF
        -DLIBUNWIND_USE_COMPILER_RT=ON
        -DLLVM_ENABLE_LIBEDIT=OFF
        -DLLVM_ENABLE_LIBXML2=OFF
        -DLLVM_OPTIMIZED_TABLEGEN=ON
    )

    local stage3=(
        -DCOMPILER_RT_BUILD_LIBFUZZER=OFF
        -DCOMPILER_RT_BUILD_MEMPROF=OFF
        -DCOMPILER_RT_BUILD_ORC=ON
        -DCOMPILER_RT_BUILD_PROFILE=OFF
        -DCOMPILER_RT_BUILD_SANITIZERS=ON
        -DCOMPILER_RT_BUILD_XRAY=OFF
        -DCOMPILER_RT_CXX_LIBRARY=libcxx
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON
        -DCOMPILER_RT_USE_LIBEXECINFO=OFF
        -DLIBCXX_CXX_ABI_INCLUDE_PATHS="${EPREFIX}/usr/include/c++/v1"
        -DLIBCXX_CXX_ABI=system-libcxxabi
        -DLIBCXX_ENABLE_ASSERTIONS=ON
        -DLIBCXX_ENABLE_LOCALIZATION=ON
        -DLIBCXX_ENABLE_NEW_DELETE_DEFINITIONS=ON
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=ON
        -DLIBCXX_USE_COMPILER_RT=ON
        -DLIBCXXABI_ENABLE_STATIC_UNWINDER=ON
        -DLIBCXXABI_USE_COMPILER_RT=ON
        -DLIBUNWIND_ENABLE_ASSERTIONS=ON
        -DLIBUNWIND_ENABLE_CROSS_UNWINDING=ON
        -DLIBUNWIND_ENABLE_STATIC=ON
        -DLIBUNWIND_INCLUDE_TESTS=OFF
        -DLIBUNWIND_INSTALL_HEADERS=ON
        -DLIBUNWIND_USE_COMPILER_RT=ON
        -DLLVM_ENABLE_LIBCXX=ON
        -DLLVM_ENABLE_LIBEDIT=ON
        -DLLVM_ENABLE_LIBXML2=ON
        -DLLVM_ENABLE_LLD=ON
        -DLLVM_ENABLE_TERMINFO=ON
        -DLLVM_OPTIMIZED_TABLEGEN=ON
        -DCMAKE_C_COMPILER=/usr/bin/clang
		-DCMAKE_CXX_COMPILER=/usr/bin/clang++
		-DCMAKE_AR=/usr/bin/llvm-ar
		-DCMAKE_NM=/usr/bin/llvm-nm
		-DCMAKE_RANLIB=/usr/bin/llvm-ranlib
		-DCLANG_DEFAULT_LINKER=/usr/bin/ld.lld
    )

    if use bootstrap; then
        mycmakeargs+=("${common[@]}" "${bootstrap[@]}")
    elif use stage2; then
        mycmakeargs+=("${common[@]}" "${stage2[@]}")
    else
        mycmakeargs+=("${common[@]}" "${stage3[@]}")
    fi

    if ! use bootstrap; then
       local -x CC=clang
       local -x CXX=clang++
       local -x CC="clang"
       local -x CPP="clang-cpp"
       local -x CXX="clang++"
       local -x AR="llvm-ar"
       local -x NM="llvm-nm"
       local -x RANLIB="llvm-ranlib"
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

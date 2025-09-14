# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="release/$(ver_cut 1).x"

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

SNAPSHOT=cd708029e0b2869e80abe31ddb175f7c35361f90

SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/llvm"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="amdgpu arm assertions bootstrap bpf cuda debug libcxx libcxxabi libfuzzer nvptx orc sanitizers static_analyzer -sysclang syslibcxxabi test wasm xcore"

DEPEND="
    lib-core/libffi
    lib-core/libxml2
    virtual/curses
"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

PATCHES=(
   "${FILESDIR}/install-prefix.patch"
)

src_prepare() {
    # drop any stray CET control-flow flags that might sneak in from environment
    # CET is x86-only so make sure arm64 never sees it
    use arm64 && filter-flags -fcf-protection=* -mshstk -mcet
	use arm64 && append-cppflags -U_LIBUNWIND_USE_CET

    cmake_src_prepare
    sed -i '/#include <string>/a #include <cstdint>' "include/llvm/Support/Signals.h" || die
}

src_configure() {
    export TUPLE

    if command -v gcc >/dev/null 2>&1; then
        TUPLE=$(gcc -dumpmachine)
    else
        TUPLE=$(clang --print-target-triple)
    fi

    if use syslibcxxabi; then
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
    fi

    filter-clang
    filter-lto

    local LLVM_TARGETS=""
    local LLVM_RUNTIMES="libunwind;compiler-rt"

    use libcxx && LLVM_RUNTIMES+=";libcxx"
    use libcxxabi && LLVM_RUNTIMES+=";libcxxabi"

    case "${CHOST}" in
        *aarch64*) LLVM_TARGETS+="AArch64" ;;
        *x86_64*)  LLVM_TARGETS+="X86" ;;
        *)         die "Unsupported host architecture: ${CHOST}" ;;
    esac

    use amdgpu && LLVM_TARGETS+=";AMDGPU"
    use arm && LLVM_TARGETS+=";ARM"
    use bpf && LLVM_TARGETS+=";BPF"
    use nvptx && LLVM_TARGETS+=";NVPTX"
    use wasm && LLVM_TARGETS+=";WebAssembly"
    use xcore && LLVM_TARGETS+=";XCore"

    echo "Selected LLVM targets: ${LLVM_TARGETS}"
    echo "Selected LLVM runtimes: ${LLVM_RUNTIMES}"

    # decide CET for runtimes
    # CET only applies to x86 and is controlled per runtime via official CMake options
    local CET=OFF
    if use elibc_glibc && [[ ${CHOST} == *x86_64* || ${CHOST} == i?86-* ]]; then
        CET=ON
    fi

    local common=(
        -DBUILD_SHARED_LIBS=OFF
        -DCLANG_DEFAULT_OPENMP_RUNTIME=libomp
        -DCLANG_DEFAULT_PIE_ON_LINUX=ON
        -DCLANG_DEFAULT_RTLIB=compiler-rt
        -DCLANG_DEFAULT_UNWINDLIB=libunwind
        -DCLANG_ENABLE_ARCMT=OFF
        -DCLANG_ENABLE_LIBXML2=ON
        -DCLANG_ENABLE_STATIC_ANALYZER=$(usex static_analyzer)
        -DCLANG_INCLUDE_TESTS=OFF
        -DCLANG_LINK_CLANG_DYLIB=ON
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DLLVM_LINKER_WORKS=1
        -DCMAKE_CXX_STANDARD=17
        -DCMAKE_DISABLE_FIND_PACKAGE_CUDAToolkit=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_hsa-runtime64=ON
        -DCMAKE_INSTALL_LIBDIR=lib
        -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
        -DCOMPILER_RT_BUILD_GWP_ASAN=OFF
        -DCOMPILER_RT_BUILD_LIBFUZZER=$(usex libfuzzer)
        -DCOMPILER_RT_BUILD_MEMPROF=OFF
        -DCOMPILER_RT_BUILD_ORC=$(usex orc)
        -DCOMPILER_RT_BUILD_PROFILE=OFF
        -DCOMPILER_RT_BUILD_SANITIZERS=$(usex sanitizers)
        -DCOMPILER_RT_BUILD_XRAY=OFF
        -DCOMPILER_RT_DEFAULT_TARGET_TRIPLE=${TUPLE}
        -DCOMPILER_RT_USE_LIBEXECINFO=OFF
        -DCOMPILER_RT_USE_LLVM_UNWINDER=ON
        -DENABLE_LINKER_BUILD_ID=ON
        -DLIBUNWIND_ENABLE_ASSERTIONS=$(usex assertions)
        -DLIBUNWIND_ENABLE_CROSS_UNWINDING=OFF
        -DLIBUNWIND_ENABLE_SHARED=ON
        -DLIBUNWIND_ENABLE_GCS=${CET}
        -DLIBUNWIND_ENABLE_STATIC=ON
        -DLIBUNWIND_INCLUDE_TESTS=OFF
        -DLIBUNWIND_INSTALL_HEADERS=ON
        -DLIBUNWIND_SUPPORTS_FNO_EXCEPTIONS_FLAG=OFF
        -DLIBUNWIND_SUPPORTS_FUNWIND_TABLES_FLAG=OFF
        -DLIBUNWIND_USE_COMPILER_RT=ON
        -DLLVM_APPEND_VC_REV=OFF
        -DLLVM_BUILD_DOCS=OFF
        -DLLVM_BUILD_LLVM_DYLIB=ON
        -DLLVM_BUILD_TESTS=$(usex test)
        -DLLVM_BUILD_TOOLS=ON
        -DLLVM_DEFAULT_TARGET_TRIPLE=${TUPLE}
        -DLLVM_ENABLE_ASSERTIONS=$(usex assertions)
        -DLLVM_ENABLE_CUDA=$(usex cuda)
        -DLLVM_ENABLE_CURL=ON
        -DLLVM_ENABLE_DOXYGEN=OFF
        -DLLVM_ENABLE_EH=ON
        -DLLVM_ENABLE_FFI=ON
        -DLLVM_ENABLE_LIBEDIT=ON
        -DLLVM_ENABLE_LIBPFM=OFF
        -DLLVM_ENABLE_LIBXML2=ON
        -DLLVM_ENABLE_OCAMLDOC=OFF
        -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=ON
        -DLLVM_ENABLE_PROJECTS="llvm;clang;lld"
        -DLLVM_ENABLE_RTTI=ON
        -DLLVM_ENABLE_RUNTIMES="${LLVM_RUNTIMES}"
        -DLLVM_ENABLE_SPHINX=OFF
        -DLLVM_ENABLE_TERMINFO=ON
        -DLLVM_ENABLE_ZLIB=ON
        -DLLVM_ENABLE_ZSTD=FORCE_ON
        -DLLVM_HOST_TRIPLE=${TUPLE}
        -DLLVM_INCLUDE_BENCHMARKS=OFF
        -DLLVM_INCLUDE_DOCS=OFF
        -DLLVM_INCLUDE_EXAMPLES=OFF
        -DLLVM_INCLUDE_TESTS=OFF
        -DLLVM_INSTALL_UTILS=ON
        -DLLVM_LINK_LLVM_DYLIB=ON
        -DLLVM_OPTIMIZED_TABLEGEN=ON
        -DLLVM_PARALLEL_LINK_JOBS=1
        -DLLVM_TARGETS_TO_BUILD="${LLVM_TARGETS}"
        -DOCAMLFIND=NO

        # CET runtime toggles
        -DLIBUNWIND_ENABLE_CET=${CET}
        -DLIBCXX_ENABLE_CET=${CET}
        -DLIBCXXABI_ENABLE_CET=${CET}
        -DCOMPILER_RT_ENABLE_CET=${CET}
    )

    local bootstrap=(
        -DBOOTSTRAP_BOOTSTRAP_LLVM_ENABLE_LLD=ON
        -DBOOTSTRAP_LLVM_ENABLE_LLD=ON
        -DBOOTSTRAP_LLVM_ENABLE_LTO=ON
        -DCLANG_BOOTSTRAP_PASSTHROUGH="CMAKE_INSTALL_PREFIX;CMAKE_VERBOSE_MAKEFILE"
        -DCLANG_ENABLE_BOOTSTRAP=ON
    )

    local cxxabi=(
        -DLIBCXXABI_ENABLE_SHARED=ON
        -DLIBCXXABI_ENABLE_STATIC_UNWINDER=ON
        -DLIBCXXABI_ENABLE_STATIC=ON
        -DLIBCXXABI_INCLUDE_TESTS=OFF
        -DLIBCXXABI_LIBUNWIND_INCLUDES="${EPREFIX}"/usr/include
        -DLIBCPP_HAS_MUSL_LIBC=$(usex elibc_musl)
    )

    local libcxx=(
        -DLIBCXX_ENABLE_ASSERTIONS=$(usex assertions)
        -DLIBCXX_ENABLE_LOCALIZATION=ON
        -DLIBCXX_ENABLE_NEW_DELETE_DEFINITIONS=ON
        -DLIBCXX_HAS_MUSL_LIBC=$(usex elibc_musl)
        -DLIBCXX_INCLUDE_BENCHMARKS=OFF
        -DLIBCXX_INCLUDE_TESTS=OFF
        -DLIBCXX_HARDENING_MODE=fast
    )

    local syslibcxxabi=(
        -DLLVM_ENABLE_LIBCXX=ON
        -DLIBCXX_CXX_ABI=system-libcxxabi
        -DCLANG_DEFAULT_CXX_STDLIB=libc++
        -DCOMPILER_RT_CXX_LIBRARY=libcxx
        -DLIBCXX_CXX_ABI_INCLUDE_PATHS=ON
        -DLIBCXXABI_USE_COMPILER_RT=ON
        -DLIBCXXABI_USE_LLVM_UNWINDER=ON
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=ON
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON
    )

    local sysclang=(
        -DCLANG_DEFAULT_LINKER=ld.lld
        -DCMAKE_AR=llvm-ar
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER="clang++"
        -DCMAKE_NM=llvm-nm
        -DCMAKE_RANLIB=llvm-ranlib
    )

    mycmakeargs=("${common[@]}")

    if use sysclang; then
        mycmakeargs+=("${sysclang[@]}")
    fi

    if use bootstrap; then
        mycmakeargs+=("${bootstrap[@]}")
    elif use syslibcxxabi; then
        mycmakeargs+=("${cxxabi[@]}" "${syslibcxxabi[@]}")
    elif use libcxx; then
        mycmakeargs+=("${libcxx[@]}" "${cxxabi[@]}")
    fi

    if use sysclang; then
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

    dosym -r "/usr/lib/${TUPLE}/libunwind.a" "/usr/lib/libunwind.a"
    dosym -r "/usr/lib/${TUPLE}/libunwind.so" "/usr/lib/libunwind.so"
    dosym -r "/usr/lib/${TUPLE}/libunwind.so.1" "/usr/lib/libunwind.so"
    dosym -r "/usr/lib/${TUPLE}/libunwind.so.1.0" "/usr/lib/libunwind.so.1"

    if use libcxx; then
        dosym -r "/usr/lib/${TUPLE}/libc++.a" "/usr/lib/libc++.a"
        dosym -r "/usr/lib/${TUPLE}/libc++.so" "/usr/lib/libc++.so"
        dosym -r "/usr/lib/${TUPLE}/libc++.so.1" "/usr/lib/libc++.so"
        dosym -r "/usr/lib/${TUPLE}/libc++.so.1.0" "/usr/lib/libc++.so.1"
        dosym -r "/usr/lib/${TUPLE}/libc++abi.a" "/usr/lib/libc++abi.a"
        dosym -r "/usr/lib/${TUPLE}/libc++abi.so" "/usr/lib/libc++abi.so"
        dosym -r "/usr/lib/${TUPLE}/libc++abi.so.1" "/usr/lib/libc++abi.so"
        dosym -r "/usr/lib/${TUPLE}/libc++abi.so.1.0" "/usr/lib/libc++abi.so.1"
        dosym -r "/usr/lib/${TUPLE}/libc++experimental.a" "/usr/lib/libc++experimental.a"
    fi

    if use syslibcxxabi; then
        dosym -r "/usr/bin/clang" "/usr/bin/cc"
        dosym -r "/usr/bin/clang" "/usr/bin/gcc"
        dosym -r "/usr/bin/llvm-ar" "/usr/bin/ar"
        dosym -r "/usr/bin/llvm-strip" "/usr/bin/strip"
        dosym -r "/usr/bin/clang++" "/usr/bin/cxx"
        dosym -r "/usr/bin/ld.lld" "/usr/bin/ld"
    fi
}

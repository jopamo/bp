# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release/$(ver_cut 1).x"

inherit cmake flag-o-matic qa-policy toolchain-funcs

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"
SNAPSHOT=81c69e1404010ede8e16d7c975bb6e5bb17cb52c

SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/llvm"

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="amdgpu assertions bootstrap +clang-tools-extra bpf cuda debug libcxx libcxxabi libfuzzer lto nvptx orc sanitizers static_analyzer -sysclang syslibcxxabi test wasm xcore"

COMMON_DEPEND="
	app-net/curl
	lib-core/libedit
	lib-core/libffi
	lib-core/libxml2
	elibc_musl? ( lib-core/musl-bsd )
	lib-core/zlib
	app-compression/zstd
	virtual/curses
"

RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"
BDEPEND="app-lang/python"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release
QA_POLICY_SHEBANG_SANITIZE=1

PATCHES=(
   "${FILESDIR}/install-prefix.patch"
)

src_prepare() {
    sed -i \
        -e 's/^[[:space:]]*virtual[[:space:]]\+BufferKind getBufferKind() const[[:space:]]*{/    BufferKind getBufferKind() const override {/' \
        tools/llvm-mc-assemble-fuzzer/llvm-mc-assemble-fuzzer.cpp || die

    sed -i \
        -e 's|^[[:space:]]*MCInstPrinter \*IP = TheTarget->createMCInstPrinter(|  std::unique_ptr<MCInstPrinter> IP(TheTarget->createMCInstPrinter(|' \
        -e 's|^[[:space:]]*\*MAI, \*MCII, \*MRI);$|      *MAI, *MCII, *MRI));|' \
        tools/llvm-mc-assemble-fuzzer/llvm-mc-assemble-fuzzer.cpp || die

    sed -i \
        -e '/Str\.reset(TheTarget->createAsmStreamer/s/, IP,/, std::move(IP),/' \
        tools/llvm-mc-assemble-fuzzer/llvm-mc-assemble-fuzzer.cpp || die

    cmake_src_prepare

    sed -i \
        '/#include <string>/a #include <cstdint>' \
        include/llvm/Support/Signals.h || die
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
    #filter-sanitizers

	local compiler_rt_build_libfuzzer=$(usex libfuzzer)
	local compiler_rt_sanitizers_to_build=all
	if use elibc_musl; then
		# Keep the base musl bootstrap narrow for now. The exotic compiler-rt
		# paths pull in extra libc++ header consumers and expose ordering bugs.
		compiler_rt_build_libfuzzer=OFF
		compiler_rt_sanitizers_to_build="asan;msan;tsan;safestack;cfi;scudo_standalone;ubsan_minimal;gwp_asan;asan_abi"
	fi

    local LLVM_TARGETS=""
    local LLVM_RUNTIMES="libunwind;compiler-rt"

    use libcxx && LLVM_RUNTIMES+=";libcxx"
    use libcxxabi && LLVM_RUNTIMES+=";libcxxabi"

    case "${CHOST}" in
        *aarch64*) LLVM_TARGETS+="AArch64" ;;
        *x86_64*)  LLVM_TARGETS+="X86" ;;
        *)        die "Unsupported host architecture: ${CHOST}" ;;
    esac

    use amdgpu && LLVM_TARGETS+=";AMDGPU"
    #use arm && LLVM_TARGETS+=";ARM"
    use bpf && LLVM_TARGETS+=";BPF"
    if use nvptx || use cuda; then
        LLVM_TARGETS+=";NVPTX"
    fi
    use wasm && LLVM_TARGETS+=";WebAssembly"
    use xcore && LLVM_TARGETS+=";XCore"

    local LLVM_PROJECTS="llvm;clang;lld"
    use clang-tools-extra && LLVM_PROJECTS+=";clang-tools-extra"

    echo "Selected LLVM targets: ${LLVM_TARGETS}"
	echo "Selected LLVM runtimes: ${LLVM_RUNTIMES}"
	echo "Selected LLVM projects: ${LLVM_PROJECTS}"

    local common=(
		-DBUILD_SHARED_LIBS=OFF
		-DCLANG_DEFAULT_OPENMP_RUNTIME=libomp
		-DCLANG_DEFAULT_PIE_ON_LINUX=ON
		-DCLANG_DEFAULT_RTLIB=compiler-rt
		-DCLANG_DEFAULT_UNWINDLIB=libunwind
		-DCLANG_ENABLE_ARCMT=OFF
		-DCLANG_ENABLE_LIBXML2=ON
		-DCLANG_ENABLE_STATIC_ANALYZER=$(usex static_analyzer)
		-DCLANG_INCLUDE_TESTS=$(usex test)
		-DCLANG_LINK_CLANG_DYLIB=ON
		-DCMAKE_CXX_STANDARD=17
		-DCMAKE_INSTALL_LIBDIR=lib
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DCOMPILER_RT_BUILD_GWP_ASAN=OFF
		-DCOMPILER_RT_BUILD_LIBFUZZER=${compiler_rt_build_libfuzzer}
		-DCOMPILER_RT_BUILD_MEMPROF=OFF
		-DCOMPILER_RT_BUILD_ORC=$(usex orc)
		-DCOMPILER_RT_BUILD_PROFILE=OFF
		-DCOMPILER_RT_BUILD_SANITIZERS=$(usex sanitizers)
		-DCOMPILER_RT_BUILD_XRAY=OFF
		-DCOMPILER_RT_DEFAULT_TARGET_TRIPLE=${TUPLE}
		-DCOMPILER_RT_SANITIZERS_TO_BUILD=${compiler_rt_sanitizers_to_build}
		-DCOMPILER_RT_USE_LIBEXECINFO=OFF
		-DCOMPILER_RT_USE_LLVM_UNWINDER=ON
		-DENABLE_LINKER_BUILD_ID=ON
		-DLIBUNWIND_ENABLE_ASSERTIONS=$(usex assertions)
		-DLIBUNWIND_ENABLE_CROSS_UNWINDING=ON
		-DLIBUNWIND_ENABLE_SHARED=ON
		-DLIBUNWIND_ENABLE_STATIC=ON
		-DLIBUNWIND_INCLUDE_TESTS=OFF
		-DLIBUNWIND_INSTALL_HEADERS=ON
		-DLIBUNWIND_SUPPORTS_FNO_EXCEPTIONS_FLAG=OFF
		-DLIBUNWIND_SUPPORTS_FUNWIND_TABLES_FLAG=OFF
		-DLIBUNWIND_USE_COMPILER_RT=ON
		-DLLVM_APPEND_VC_REV=OFF
		# Do not build the GNU gold plugin in the LLVM-first toolchain. It
		# depends on binutils plugin headers (plugin-api.h), which are no longer
		# part of the base system.
		-DLLVM_BINUTILS_INCDIR=
		-DLLVM_BUILD_DOCS=OFF
		-DLLVM_BUILD_LLVM_DYLIB=ON
		-DLLVM_BUILD_TESTS=$(usex test)
		-DLLVM_BUILD_TOOLS=ON
		-DLLVM_DEFAULT_TARGET_TRIPLE=${TUPLE}
		-DLLVM_ENABLE_ASSERTIONS=$(usex assertions)
		-DLLVM_ENABLE_CURL=ON
		-DLLVM_ENABLE_DOXYGEN=OFF
		-DLLVM_ENABLE_EH=ON
		-DLLVM_ENABLE_FFI=ON
		-DLLVM_ENABLE_LIBEDIT=ON
		-DLLVM_ENABLE_LIBPFM=OFF
		-DLLVM_ENABLE_LIBXML2=ON
		-DLLVM_ENABLE_OCAMLDOC=OFF
		-DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=ON
		-DLLVM_ENABLE_PROJECTS="${LLVM_PROJECTS}"
		-DLLVM_ENABLE_RTTI=ON
		-DLLVM_ENABLE_RUNTIMES="${LLVM_RUNTIMES}"
		-DLLVM_ENABLE_SPHINX=OFF
		-DLLVM_ENABLE_ZLIB=ON
		-DLLVM_ENABLE_ZSTD=FORCE_ON
		-DLLVM_HOST_TRIPLE=${TUPLE}
		-DLLVM_INCLUDE_BENCHMARKS=OFF
		-DLLVM_INCLUDE_DOCS=OFF
		-DLLVM_INCLUDE_EXAMPLES=OFF
		-DLLVM_INCLUDE_TESTS=$(usex test)
		-DLLVM_INSTALL_UTILS=ON
		-DLLVM_LINK_LLVM_DYLIB=ON
		-DLLVM_OPTIMIZED_TABLEGEN=ON
		-DLLVM_PARALLEL_LINK_JOBS=1
		-DLLVM_TARGETS_TO_BUILD="${LLVM_TARGETS}"
		-DOCAMLFIND=NO
    )

    local bootstrap_passthrough=(
		CMAKE_INSTALL_PREFIX
		CMAKE_VERBOSE_MAKEFILE
    )

    if use syslibcxxabi; then
		bootstrap_passthrough+=(
			CLANG_DEFAULT_CXX_STDLIB
			CLANG_DEFAULT_RTLIB
			CLANG_DEFAULT_UNWINDLIB
			COMPILER_RT_CXX_LIBRARY
			COMPILER_RT_USE_BUILTINS_LIBRARY
			LIBCXXABI_ENABLE_SHARED
			LIBCXXABI_ENABLE_STATIC
			LIBCXXABI_ENABLE_STATIC_UNWINDER
			LIBCXXABI_INCLUDE_TESTS
			LIBCXXABI_LIBUNWIND_INCLUDES
			LIBCXXABI_USE_COMPILER_RT
			LIBCXXABI_USE_LLVM_UNWINDER
			LIBCXX_CXX_ABI
			LIBCXX_CXX_ABI_INCLUDE_PATHS
			LIBCXX_CXX_ABI_LIBRARY_PATH
			LIBCXX_ENABLE_ASSERTIONS
			LIBCXX_ENABLE_LOCALIZATION
			LIBCXX_ENABLE_NEW_DELETE_DEFINITIONS
			LIBCXX_ENABLE_STATIC_ABI_LIBRARY
			LIBCXX_HARDENING_MODE
			LIBCXX_HAS_MUSL_LIBC
			LIBCXX_INCLUDE_BENCHMARKS
			LIBCXX_INCLUDE_TESTS
			LIBUNWIND_USE_COMPILER_RT
			LLVM_ENABLE_LIBCXX
		)
    fi

    local bootstrap_passthrough_string=$(printf '%s;' "${bootstrap_passthrough[@]}")
    bootstrap_passthrough_string=${bootstrap_passthrough_string%;}

    local bootstrap=(
		-DBOOTSTRAP_BOOTSTRAP_LLVM_ENABLE_LLD=ON
		-DBOOTSTRAP_LLVM_ENABLE_LLD=ON
		-DBOOTSTRAP_LLVM_ENABLE_LTO=$(usex lto ON Off)
		-DCLANG_BOOTSTRAP_PASSTHROUGH=${bootstrap_passthrough_string}
		-DCLANG_ENABLE_BOOTSTRAP=ON
    )


	local cxxabi=(
		-DLIBCXX_HAS_MUSL_LIBC=$(usex elibc_musl)
		-DLIBCXXABI_ENABLE_SHARED=ON
		-DLIBCXXABI_ENABLE_STATIC_UNWINDER=ON
		-DLIBCXXABI_ENABLE_STATIC=ON
		-DLIBCXXABI_INCLUDE_TESTS=OFF
		-DLIBCXXABI_LIBUNWIND_INCLUDES="${EPREFIX}"/usr/include
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
        -DCLANG_DEFAULT_CXX_STDLIB=libc++
		-DCOMPILER_RT_CXX_LIBRARY=libcxx
		-DLIBCXXABI_USE_COMPILER_RT=ON
		-DLIBCXXABI_USE_LLVM_UNWINDER=ON
		-DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=ON
		-DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON
    )

    local sysclang=(
        -DCLANG_DEFAULT_LINKER=/usr/bin/ld.lld
        -DCMAKE_AR=/usr/bin/llvm-ar
        -DCMAKE_C_COMPILER=/usr/bin/clang
        -DCMAKE_CXX_COMPILER=/usr/bin/clang++
        -DCMAKE_NM=/usr/bin/llvm-nm
        -DCMAKE_RANLIB=/usr/bin/llvm-ranlib
        -DLLVM_ENABLE_LLD=ON
    )

	local llvm_lto_mode=$(usex lto ON Off)

	mycmakeargs=("${common[@]}")
	mycmakeargs+=( -DLLVM_ENABLE_LTO=${llvm_lto_mode} )

	if use sysclang; then
        mycmakeargs+=("${sysclang[@]}")
    fi

    if use syslibcxxabi; then
        use libcxx && mycmakeargs+=("${libcxx[@]}")
        mycmakeargs+=("${cxxabi[@]}" "${syslibcxxabi[@]}")
        if use libcxxabi; then
            mycmakeargs+=( -DLIBCXX_CXX_ABI=libcxxabi )
        else
            mycmakeargs+=(
                -DLIBCXX_CXX_ABI=system-libcxxabi
                -DLIBCXX_CXX_ABI_INCLUDE_PATHS=${EPREFIX}/usr/include/c++/v1
                -DLIBCXX_CXX_ABI_LIBRARY_PATH=${EPREFIX}/usr/lib
            )
        fi
    elif use libcxx; then
        mycmakeargs+=("${libcxx[@]}" "${cxxabi[@]}")
    fi

    if use bootstrap; then
        use syslibcxxabi && mycmakeargs+=( -DBOOTSTRAP_LLVM_ENABLE_LIBCXX=ON )
        mycmakeargs+=("${bootstrap[@]}")
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

    local QA_POLICY_LTO_CONFIGURE=0
    qa-policy-configure

    cmake_src_configure
}

src_compile() {
	if use libcxx && use syslibcxxabi; then
		_cmake_check_build_dir
		# compiler-rt can start before libc++ has copied its generated headers
		# into the runtimes build tree, which leaves <new> and friends missing
		# under -nostdinc++. First force the runtimes external project to
		# configure so its cache exists, then materialize the libc++ headers.
		cmake_build runtimes-configure

		local runtimes_build_dir="${BUILD_DIR}"/runtimes/runtimes-bins
		[[ -f "${runtimes_build_dir}"/CMakeCache.txt ]] || die "Missing runtimes CMake cache: ${runtimes_build_dir}"
		"${CMAKE_BINARY}" --build "${runtimes_build_dir}" --target generate-cxx-headers \
			|| die "Failed to generate libc++ headers for compiler-rt"
	fi

	cmake_src_compile
}

src_test() {
    local -x LIT_PRESERVES_TMP=1
    cmake_src_make check
}

src_install() {
    cmake_src_install

	if use elibc_musl; then
		cat > "${T}/${CHOST}.cfg" <<-EOF || die
# Auto-load musl-bsd compatibility overlays and link shims for musl targets.
-isystem
/usr/lib/musl-bsd/overlay/include
-Wl,--push-state,--as-needed
-lmusl-bsd-compat
-Wl,--pop-state
EOF
		insinto /usr/bin
		doins "${T}/${CHOST}.cfg"
	fi

	dosym -r "/usr/lib/${TUPLE}/libunwind.a" "/usr/lib/libunwind.a"
	dosym -r "/usr/lib/${TUPLE}/libunwind.so" "/usr/lib/libunwind.so"
	dosym -r "/usr/lib/${TUPLE}/libunwind.so.1" "/usr/lib/libunwind.so.1"

	if use libcxx; then
		dosym -r "/usr/lib/${TUPLE}/libc++.a" "/usr/lib/libc++.a"
		dosym -r "/usr/lib/${TUPLE}/libc++.so" "/usr/lib/libc++.so"
		dosym -r "/usr/lib/${TUPLE}/libc++.so.1" "/usr/lib/libc++.so.1"
		dosym -r "/usr/lib/${TUPLE}/libc++experimental.a" "/usr/lib/libc++experimental.a"
	fi

	if use libcxxabi; then
		dosym -r "/usr/lib/${TUPLE}/libc++abi.a" "/usr/lib/libc++abi.a"
		dosym -r "/usr/lib/${TUPLE}/libc++abi.so" "/usr/lib/libc++abi.so"
		dosym -r "/usr/lib/${TUPLE}/libc++abi.so.1" "/usr/lib/libc++abi.so.1"
	fi

	# Keep generic tool ownership with GCC/binutils during the transition.
	# Clang-first selection is handled by profile and toolchain policy, not
	# by colliding on /usr/bin/{cc,gcc,ar,ld,strip}.

	local QA_POLICY_ARCHIVE_DUPLICATE_MEMBER_ALLOW="
		/usr/lib/libclangCodeGen.a:AMDGPU.cpp.o
		/usr/lib/libclangCodeGen.a:ARM.cpp.o
		/usr/lib/libclangCodeGen.a:DirectX.cpp.o
		/usr/lib/libclangCodeGen.a:Hexagon.cpp.o
		/usr/lib/libclangCodeGen.a:NVPTX.cpp.o
		/usr/lib/libclangCodeGen.a:PPC.cpp.o
		/usr/lib/libclangCodeGen.a:RISCV.cpp.o
		/usr/lib/libclangCodeGen.a:SPIR.cpp.o
		/usr/lib/libclangCodeGen.a:SystemZ.cpp.o
		/usr/lib/libclangCodeGen.a:WebAssembly.cpp.o
		/usr/lib/libclangCodeGen.a:X86.cpp.o
	"

	qa-policy-install
}

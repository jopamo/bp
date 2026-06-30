# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release/$(ver_cut 1).x"

inherit cmake flag-o-matic qa-policy toolchain-funcs

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"
SNAPSHOT=ca7933e47d3a3451d81e72ac174dcb5aa28b59d1

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

_llvm_get_tuple() {
	if command -v gcc >/dev/null 2>&1; then
		gcc -dumpmachine
	else
		clang --print-target-triple
	fi
}

_llvm_make_tool_wrapper() {
	local out=$1
	local tool=$2
	local tool_args=${3-}

	sed \
		-e "s|@TOOL@|${tool}|g" \
		-e "s|@TOOL_ARGS@|${tool_args}|g" \
		"${FILESDIR}/tool-wrapper.in" > "${out}" || die
	chmod 0755 "${out}" || die
}

_llvm_cmd_is_clang() {
	local cmd=$1

	case ${cmd##*/} in
		clang|clang-[0-9]*|clang++|clang++-[0-9]*|clang-cpp|clang-cpp-[0-9]*)
			return 0
			;;
	esac

	return 1
}

_llvm_toolchain_usable() {
	local cc_str=$1
	local cxx_str=$2
	local -a cc_cmd=( ${cc_str} )
	local -a cxx_cmd=( ${cxx_str} )
	local src_c="${T}/llvm-compiler-smoke.c"
	local src_cxx="${T}/llvm-compiler-smoke.cpp"
	local obj_c="${T}/llvm-compiler-smoke.c.o"
	local obj_cxx="${T}/llvm-compiler-smoke.cpp.o"

	[[ ${#cc_cmd[@]} -gt 0 && ${#cxx_cmd[@]} -gt 0 ]] || return 1
	type -P "${cc_cmd[0]}" >/dev/null 2>&1 || return 1
	type -P "${cxx_cmd[0]}" >/dev/null 2>&1 || return 1

	printf '%s\n' 'int main(void) { return 0; }' > "${src_c}" || die
	printf '%s\n' 'int main() { return 0; }' > "${src_cxx}" || die

	"${cc_cmd[@]}" -c "${src_c}" -o "${obj_c}" >/dev/null 2>&1 || return 1
	"${cxx_cmd[@]}" -c "${src_cxx}" -o "${obj_cxx}" >/dev/null 2>&1 || return 1
}

_llvm_export_gcc_fallback() {
	local gcc gxx gar gnm granlib

	for gcc in "${CHOST}-gcc" gcc; do
		type -P "${gcc}" >/dev/null 2>&1 && break
		gcc=
	done
	for gxx in "${CHOST}-g++" g++; do
		type -P "${gxx}" >/dev/null 2>&1 && break
		gxx=
	done
	[[ -n ${gcc} && -n ${gxx} ]] || return 1

	for gar in "${CHOST}-gcc-ar" gcc-ar "${CHOST}-ar" ar; do
		type -P "${gar}" >/dev/null 2>&1 && break
		gar=
	done
	for gnm in "${CHOST}-gcc-nm" gcc-nm "${CHOST}-nm" nm; do
		type -P "${gnm}" >/dev/null 2>&1 && break
		gnm=
	done
	for granlib in "${CHOST}-gcc-ranlib" gcc-ranlib "${CHOST}-ranlib" ranlib; do
		type -P "${granlib}" >/dev/null 2>&1 && break
		granlib=
	done

	export CC=${gcc}
	export CPP="${gcc} -E"
	export CXX=${gxx}
	[[ -n ${gar} ]] && export AR=${gar}
	[[ -n ${gnm} ]] && export NM=${gnm}
	[[ -n ${granlib} ]] && export RANLIB=${granlib}
}

src_prepare() {
    # S points at the llvm subproject, but this driver integration patch
    # touches the sibling clang tree in the llvm-project monorepo.
    pushd "${WORKDIR}/llvm-project-${SNAPSHOT}" >/dev/null || die
    eapply "${FILESDIR}/musl-bsd-driver-integration.patch"
    popd >/dev/null || die

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

    TUPLE=$(_llvm_get_tuple)

	local sysclang_requested=0
	local current_cc=$(tc-getCC)
	local current_cxx=$(tc-getCXX)
	local -a current_cc_cmd=( ${current_cc} )
	local -a current_cxx_cmd=( ${current_cxx} )

	use sysclang && sysclang_requested=1

	if (( sysclang_requested )); then
		if ! _llvm_toolchain_usable /usr/bin/clang /usr/bin/clang++; then
			ewarn "USE=sysclang requested, but /usr/bin/clang or /usr/bin/clang++ is missing or unusable."
			ewarn "Falling back to GCC for the build compiler."
			_llvm_export_gcc_fallback || die "No usable GCC fallback found"
			sysclang_requested=0
		fi
	elif { _llvm_cmd_is_clang "${current_cc_cmd[0]}" || _llvm_cmd_is_clang "${current_cxx_cmd[0]}"; } \
		&& ! _llvm_toolchain_usable "${current_cc}" "${current_cxx}"; then
		ewarn "Selected Clang toolchain is missing or unusable:"
		ewarn "  CC=${current_cc}"
		ewarn "  CXX=${current_cxx}"
		ewarn "Falling back to GCC for the build compiler."
		_llvm_export_gcc_fallback || die "No usable GCC fallback found"
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
	local compiler_rt_default_target_only=OFF
	local compiler_rt_sanitizers_to_build=all
	if use elibc_musl; then
		# Keep the base musl bootstrap narrow for now. The exotic compiler-rt
		# paths pull in extra libc++ header consumers and expose ordering bugs.
		compiler_rt_build_libfuzzer=OFF
		# musl installs arch-specific register headers, so the x86 compiler-rt
		# multilib probe can wander into i386 sanitizer builds on x86_64 and
		# then explode on sys/user.h field mismatches (esp vs rsp). This distro
		# is not shipping x86 multilib runtimes here anyway, so constrain
		# compiler-rt to the default target on musl.
		compiler_rt_default_target_only=ON
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

	local runtimes_cmake_args=()
	if use elibc_musl; then
		# During the first LLVM bootstrap on musl, the runtimes external
		# project is configured with the just-built Clang before libunwind is
		# installed. Executable try_compiles therefore fail by construction and
		# poison basic flag probes such as -fno-exceptions and --unwindlib=none,
		# which then trips libunwind's hard configure check. Keep these probes
		# compile-only; the real runtime build still performs the actual links.
		runtimes_cmake_args+=( -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY )
		# But that compile-only mode also makes check_library_exists() lie:
		# any referenced symbol appears "found" because no link ever happens.
		# libc++abi then hard-defines HAVE___CXA_THREAD_ATEXIT_IMPL and later
		# tries to link against glibc's __cxa_thread_atexit_impl, which musl
		# does not provide. Force the cache back to reality on musl so
		# libc++abi uses its weak-symbol/fallback path instead.
		runtimes_cmake_args+=( -DLIBCXXABI_HAS_CXA_THREAD_ATEXIT_IMPL=OFF )
	fi

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
		-DCOMPILER_RT_USE_LIBEXECINFO=OFF
		-DCOMPILER_RT_USE_LLVM_UNWINDER=ON
		-DENABLE_LINKER_BUILD_ID=ON
		-DLIBUNWIND_ENABLE_ASSERTIONS=$(usex assertions)
		-DLIBUNWIND_ENABLE_CROSS_UNWINDING=ON
		-DLIBUNWIND_ENABLE_SHARED=ON
		-DLIBUNWIND_ENABLE_STATIC=ON
		-DLIBUNWIND_INCLUDE_TESTS=OFF
		-DLIBUNWIND_INSTALL_HEADERS=ON
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
	mycmakeargs+=(
		-DCOMPILER_RT_DEFAULT_TARGET_ONLY=${compiler_rt_default_target_only}
		-DCOMPILER_RT_SANITIZERS_TO_BUILD=${compiler_rt_sanitizers_to_build}
	)
	# In default-target-only mode compiler-rt derives its triple from
	# CMAKE_C_COMPILER_TARGET and rejects an explicit
	# COMPILER_RT_DEFAULT_TARGET_TRIPLE.
	if [[ ${compiler_rt_default_target_only} != ON ]]; then
		mycmakeargs+=( -DCOMPILER_RT_DEFAULT_TARGET_TRIPLE=${TUPLE} )
	fi
	mycmakeargs+=( -DLLVM_ENABLE_LTO=${llvm_lto_mode} )
	if [[ ${#runtimes_cmake_args[@]} -gt 0 ]]; then
		local runtimes_cmake_args_string=$(printf '%s;' "${runtimes_cmake_args[@]}")
		mycmakeargs+=( -DRUNTIMES_CMAKE_ARGS="${runtimes_cmake_args_string%;}" )
	fi

	if (( sysclang_requested )); then
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

    if (( sysclang_requested )); then
       local -x CC="/usr/bin/clang"
       if [[ -x /usr/bin/clang-cpp ]]; then
           local -x CPP="/usr/bin/clang-cpp"
       else
           local -x CPP="/usr/bin/clang -E"
       fi
       local -x CXX="/usr/bin/clang++"
       local -x AR="/usr/bin/llvm-ar"
       local -x NM="/usr/bin/llvm-nm"
       local -x RANLIB="/usr/bin/llvm-ranlib"
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

	: "${TUPLE:=$(_llvm_get_tuple)}"

	local clang_cpp_generic="${T}/clang-cpp"
	local clang_cpp_target="${T}/${TUPLE}-cpp"

	sed \
		-e 's|@CLANG@|/usr/bin/clang|g' \
		-e 's|@TARGET_FLAGS@||g' \
		"${FILESDIR}/clang-cpp-wrapper.in" > "${clang_cpp_generic}" || die
	chmod 0755 "${clang_cpp_generic}" || die

	sed \
		-e 's|@CLANG@|/usr/bin/clang|g' \
		-e "s|@TARGET_FLAGS@|--target=${TUPLE}|g" \
		"${FILESDIR}/clang-cpp-wrapper.in" > "${clang_cpp_target}" || die
	chmod 0755 "${clang_cpp_target}" || die

	rm -f "${ED}/usr/bin/clang-cpp" || die
	exeinto /usr/bin
	newexe "${clang_cpp_generic}" clang-cpp

	exeinto /usr/libexec/llvm-wrappers
	newexe "${clang_cpp_target}" "${TUPLE}-cpp"
	dosym -r "/usr/libexec/llvm-wrappers/${TUPLE}-cpp" "/usr/bin/${TUPLE}-cpp"

	if use elibc_musl; then
		local defaults_build_dir="${T}/llvm-defaults"
		mkdir -p "${defaults_build_dir}" || die

		_llvm_make_tool_wrapper "${defaults_build_dir}/cc" /usr/bin/clang "--target=${TUPLE}"
		_llvm_make_tool_wrapper "${defaults_build_dir}/c++" /usr/bin/clang++ "--target=${TUPLE}"
		_llvm_make_tool_wrapper "${defaults_build_dir}/cpp" "/usr/bin/${TUPLE}-cpp"
		_llvm_make_tool_wrapper "${defaults_build_dir}/ld" /usr/bin/ld.lld
		_llvm_make_tool_wrapper "${defaults_build_dir}/ar" /usr/bin/llvm-ar
		_llvm_make_tool_wrapper "${defaults_build_dir}/ranlib" /usr/bin/llvm-ranlib
		_llvm_make_tool_wrapper "${defaults_build_dir}/nm" /usr/bin/llvm-nm
		_llvm_make_tool_wrapper "${defaults_build_dir}/strip" /usr/bin/llvm-strip
		_llvm_make_tool_wrapper "${defaults_build_dir}/objcopy" /usr/bin/llvm-objcopy
		_llvm_make_tool_wrapper "${defaults_build_dir}/objdump" /usr/bin/llvm-objdump
		_llvm_make_tool_wrapper "${defaults_build_dir}/readelf" /usr/bin/llvm-readelf

		exeinto /usr/libexec/llvm-defaults
		local tool
		for tool in cc c++ cpp ld ar ranlib nm strip objcopy objdump readelf; do
			doexe "${defaults_build_dir}/${tool}"
		done

		cat > "${T}/05llvm-default-toolchain" <<-'EOF' || die
PATH=/usr/libexec/llvm-defaults
EOF
		doenvd "${T}/05llvm-default-toolchain"
	fi

	dosym -r "/usr/lib/${TUPLE}/libunwind.a" "/usr/lib/libunwind.a"
	dosym -r "/usr/lib/${TUPLE}/libunwind.so" "/usr/lib/libunwind.so"
	dosym -r "/usr/lib/${TUPLE}/libunwind.so.1" "/usr/lib/libunwind.so.1"

	if use libcxx; then
		dosym -r "/usr/lib/${TUPLE}/libc++.a" "/usr/lib/libc++.a"
		dosym -r "/usr/lib/${TUPLE}/libc++.so" "/usr/lib/libc++.so"
		dosym -r "/usr/lib/${TUPLE}/libc++.so.1" "/usr/lib/libc++.so.1"
		dosym -r "/usr/lib/${TUPLE}/libc++experimental.a" "/usr/lib/libc++experimental.a"

		# libc++ includes <__config_site> from the generic include root, but on
		# musl/native layouts the generated header can land only under the
		# target-qualified include dir. Mirror it into the generic search root.
		if [[ -e "${ED}/usr/include/${TUPLE}/c++/v1/__config_site" ]]; then
			dosym -r "/usr/include/${TUPLE}/c++/v1/__config_site" \
				"/usr/include/c++/v1/__config_site"
		fi
	fi

	if use libcxxabi; then
		dosym -r "/usr/lib/${TUPLE}/libc++abi.a" "/usr/lib/libc++abi.a"
		dosym -r "/usr/lib/${TUPLE}/libc++abi.so" "/usr/lib/libc++abi.so"
		dosym -r "/usr/lib/${TUPLE}/libc++abi.so.1" "/usr/lib/libc++abi.so.1"
	fi

	# Keep /usr/bin ownership with GCC/binutils. Musl resolves the generic
	# tool names through /usr/libexec/llvm-defaults via env.d, while glibc
	# keeps the GNU toolchain as the default path resolution.

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

pkg_postinst() {
	local c99="${EROOT%/}/usr/bin/c99"

	# Backfill the POSIX c99 frontend on LLVM-first systems, but do not
	# trample an existing provider.
	if [[ ! -e ${c99} && ! -L ${c99} ]]; then
		cat > "${c99}" <<-'EOF' || die
#!/bin/sh
exec cc -std=c99 "$@"
EOF
		chmod 0755 "${c99}" || die
	fi

	use elibc_musl || return 0

	local cfg="${EROOT%/}/usr/bin/${CHOST}.cfg"
	local old_cfg_contents=$'# Auto-load musl-bsd compatibility overlays and link shims for musl targets.\n-isystem\n/usr/lib/musl-bsd/overlay/include\n-Wl,--push-state,--as-needed\n-lmusl-bsd-compat\n-Wl,--pop-state'
	local cfg_contents

	[[ -f ${cfg} ]] || return 0

	if ! cfg_contents=$(<"${cfg}"); then
		ewarn "Unable to read obsolete Clang config ${cfg}; remove it manually if it still overrides Clang defaults."
		return 0
	fi

	if [[ ${cfg_contents} == "${old_cfg_contents}" ]]; then
		if rm -f "${cfg}"; then
			elog "Removed obsolete Clang config ${cfg}; musl-bsd integration is now built into the driver."
			elog "Direct musl-bsd symbol users now auto-link via --as-needed when libmusl-bsd-compat is present in the active sysroot, and musl executables that later dlopen glibc-targeted DSOs should be built with -fmusl-bsd-load-compat."
		else
			ewarn "Failed to remove obsolete Clang config ${cfg}."
			ewarn "That file keeps the old musl-bsd integration path active and overrides the new driver behavior."
		fi
	else
		ewarn "Leaving ${cfg} in place because its contents differ from the old auto-generated musl-bsd config."
		ewarn "If you no longer want external Clang config injection, remove or update that file manually."
		ewarn "The new built-in mode auto-links direct musl-bsd symbol users with --as-needed when libmusl-bsd-compat is present in the active sysroot, and uses -fmusl-bsd-load-compat for executables that must host glibc-targeted DSOs."
	fi
}

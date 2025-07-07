# Distributed under the terms of the GNU General Public License v2

# @ECLASS: toolchain-funcs.eclass
# @SUPPORTED_EAPIS: 6 7 8
# @BLURB: Linux toolchain query functions

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_TOOLCHAIN_FUNCS_ECLASS} ]]; then
_TOOLCHAIN_FUNCS_ECLASS=1

inherit emoji

# Resolves toolchain program for CHOST/CBUILD
_tc-getPROG() {
	local tuple=$1
	local vars=$2
	local prog=( $3 )
	local var=${vars%% *}
	local v

	for v in ${vars}; do
		if [[ -n ${!v} ]]; then
			export ${var}="${!v}"
			echo "${!v}"
			return 0
		fi
	done

	local search=
	[[ -n $4 ]] && search=$(type -p $4-${prog[0]})
	[[ -z ${search} && -n ${!tuple} ]] && search=$(type -p ${!tuple}-${prog[0]})
	[[ -n ${search} ]] && prog[0]=${search##*/}

	export ${var}="${prog[*]}"
	echo "${!var}"
}

tc-getBUILD_PROG() {
	local vars="BUILD_$1 $1_FOR_BUILD HOST$1"
	tc-is-cross-compiler || vars+=" $1"
	_tc-getPROG CBUILD "${vars}" "${@:2}"
}
tc-getPROG() { _tc-getPROG CHOST "$@"; }

# Main Linux toolchain functions
tc-getAR()      { tc-getPROG AR ar "$@"; }
tc-getAS()      { tc-getPROG AS as "$@"; }
tc-getCC()      { tc-getPROG CC gcc "$@"; }
tc-getCPP()     { tc-getPROG CPP "${CC:-gcc} -E" "$@"; }
tc-getCXX()     { tc-getPROG CXX g++ "$@"; }
tc-getLD()      { tc-getPROG LD ld "$@"; }
tc-getSTRINGS() { tc-getPROG STRINGS strings "$@"; }
tc-getSTRIP()   { tc-getPROG STRIP strip "$@"; }
tc-getNM()      { tc-getPROG NM nm "$@"; }
tc-getRANLIB()  { tc-getPROG RANLIB ranlib "$@"; }
tc-getREADELF() { tc-getPROG READELF readelf "$@"; }
tc-getOBJCOPY() { tc-getPROG OBJCOPY objcopy "$@"; }
tc-getOBJDUMP() { tc-getPROG OBJDUMP objdump "$@"; }
tc-getF77()     { tc-getPROG F77 gfortran "$@"; }
tc-getFC()      { tc-getPROG FC gfortran "$@"; }
tc-getGO()      { tc-getPROG GO gccgo "$@"; }
tc-getPKG_CONFIG() { tc-getPROG PKG_CONFIG pkg-config "$@"; }

# Cross and build tools
tc-getBUILD_AR()      { tc-getBUILD_PROG AR ar "$@"; }
tc-getBUILD_AS()      { tc-getBUILD_PROG AS as "$@"; }
tc-getBUILD_CC()      { tc-getBUILD_PROG CC gcc "$@"; }
tc-getBUILD_CPP()     { tc-getBUILD_PROG CPP "$(tc-getBUILD_CC) -E" "$@"; }
tc-getBUILD_CXX()     { tc-getBUILD_PROG CXX g++ "$@"; }
tc-getBUILD_LD()      { tc-getBUILD_PROG LD ld "$@"; }
tc-getBUILD_STRINGS() { tc-getBUILD_PROG STRINGS strings "$@"; }
tc-getBUILD_STRIP()   { tc-getBUILD_PROG STRIP strip "$@"; }
tc-getBUILD_NM()      { tc-getBUILD_PROG NM nm "$@"; }
tc-getBUILD_RANLIB()  { tc-getBUILD_PROG RANLIB ranlib "$@"; }
tc-getBUILD_READELF() { tc-getBUILD_PROG READELF readelf "$@"; }
tc-getBUILD_OBJCOPY() { tc-getBUILD_PROG OBJCOPY objcopy "$@"; }
tc-getBUILD_PKG_CONFIG() { tc-getBUILD_PROG PKG_CONFIG pkg-config "$@"; }

tc-getTARGET_CPP() {
	if [[ -n ${CTARGET} ]]; then
		_tc-getPROG CTARGET TARGET_CPP "gcc -E" "$@"
	else
		tc-getCPP "$@"
	fi
}

# Export a set of toolchain vars
tc-export() {
	local var
	for var in "$@"; do
		[[ $(type -t "tc-get${var}") != "function" ]] && die "tc-export: invalid export variable '${var}'"
		"tc-get${var}" > /dev/null
	done
}

tc-is-cross-compiler() {
	[[ ${CBUILD:-${CHOST}} != ${CHOST} ]]
}

# @FUNCTION: tc-cpp-is-true
# @USAGE: <condition> [cpp flags]
# @RETURN: Shell true if the condition is true, shell false otherwise
# Checks the given preprocessor condition using the current toolchain
tc-cpp-is-true() {
	local CONDITION=${1}
	shift

	$(tc-getTARGET_CPP) "$@" -P - <<-EOF >/dev/null 2>&1
		#if ${CONDITION}
		true
		#else
		#error false
		#endif
	EOF
}

# @FUNCTION: tc-detect-is-softfloat
# @RETURN: always fails (not relevant for amd64 or arm64)
# Not implemented, these arches are always hardfloat
tc-detect-is-softfloat() {
	return 1
}

# @FUNCTION: tc-tuple-is-softfloat
# @RETURN: always "no" for supported arches
tc-tuple-is-softfloat() {
	case ${CTARGET:-${CHOST}} in
		amd64*|x86_64*|arm64*|aarch64*) echo "no" ;;
		*) echo "no" ;;
	esac
}

# @FUNCTION: tc-is-softfloat
# @DESCRIPTION:
# Returns "no" for amd64 and arm64, as only hardfloat is supported here.
tc-is-softfloat() {
	echo "no"
}

# @FUNCTION: tc-is-static-only
# @DESCRIPTION:
# Returns false, since both amd64 and arm64 support shared libs
tc-is-static-only() {
	return 1
}

# @FUNCTION: tc-stack-grows-down
# @DESCRIPTION:
# Returns true for all supported arches (stack grows down)
tc-stack-grows-down() {
	return 0
}

# @FUNCTION: tc-export_build_env
# @USAGE: [compiler variables]
# @DESCRIPTION:
# Export build-related compiler settings for cross and native builds
tc-export_build_env() {
	tc-export "$@"
	if tc-is-cross-compiler; then
		: "${BUILD_CFLAGS:=-O1 -pipe}"
		: "${BUILD_CXXFLAGS:=-O1 -pipe}"
		: "${BUILD_CPPFLAGS:= }"
		: "${BUILD_LDFLAGS:= }"
	else
		: "${BUILD_CFLAGS:=${CFLAGS}}"
		: "${BUILD_CXXFLAGS:=${CXXFLAGS}}"
		: "${BUILD_CPPFLAGS:=${CPPFLAGS}}"
		: "${BUILD_LDFLAGS:=${LDFLAGS}}"
	fi
	export BUILD_{C,CXX,CPP,LD}FLAGS

	local v
	for v in BUILD_{C,CXX,CPP,LD}FLAGS ; do
		export ${v#BUILD_}_FOR_BUILD="${!v}"
	done
}

# @FUNCTION: tc-env_build
# @USAGE: <command> [command args]
# @DESCRIPTION:
# Setup the build env to the build tools and execute the command
tc-env_build() {
	tc-export_build_env
	CFLAGS=${BUILD_CFLAGS} \
	CXXFLAGS=${BUILD_CXXFLAGS} \
	CPPFLAGS=${BUILD_CPPFLAGS} \
	LDFLAGS=${BUILD_LDFLAGS} \
	AR=$(tc-getBUILD_AR) \
	AS=$(tc-getBUILD_AS) \
	CC=$(tc-getBUILD_CC) \
	CPP=$(tc-getBUILD_CPP) \
	CXX=$(tc-getBUILD_CXX) \
	LD=$(tc-getBUILD_LD) \
	NM=$(tc-getBUILD_NM) \
	PKG_CONFIG=$(tc-getBUILD_PKG_CONFIG) \
	RANLIB=$(tc-getBUILD_RANLIB) \
	READELF=$(tc-getBUILD_READELF) \
	"$@"
}

# @FUNCTION: econf_build
# @USAGE: [econf flags]
# @DESCRIPTION:
# Run econf using build (CBUILD) tools
econf_build() {
	local CBUILD=${CBUILD:-${CHOST}}
	econf_env() { CHOST=${CBUILD} econf "$@"; }
	tc-env_build econf_env "$@"
}

# @FUNCTION: tc-ld-is-gold
# @USAGE: [toolchain prefix]
# @DESCRIPTION:
# Return true if the current linker is gold
tc-ld-is-gold() {
	local out
	local -x LC_ALL=C

	out=$($(tc-getLD "$@") --version 2>&1)
	[[ ${out} == *"GNU gold"* ]] && return 0

	local base="${T}/test-tc-gold"
	cat <<-EOF > "${base}.c"
	int main(void) { return 0; }
	EOF
	out=$($(tc-getCC "$@") ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -Wl,--version "${base}.c" -o "${base}" 2>&1)
	rm -f "${base}"*
	[[ ${out} == *"GNU gold"* ]] && return 0

	return 1
}

# @FUNCTION: tc-ld-is-lld
# @USAGE: [toolchain prefix]
# @DESCRIPTION:
# Return true if the current linker is lld
tc-ld-is-lld() {
	local out
	local -x LC_ALL=C

	out=$($(tc-getLD "$@") --version 2>&1)
	[[ ${out} == *"LLD"* ]] && return 0

	local base="${T}/test-tc-lld"
	cat <<-EOF > "${base}.c"
	int main(void) { return 0; }
	EOF
	out=$($(tc-getCC "$@") ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -Wl,--version "${base}.c" -o "${base}" 2>&1)
	rm -f "${base}"*
	[[ ${out} == *"LLD"* ]] && return 0

	return 1
}

# @FUNCTION: tc-ld-disable-gold
# @USAGE: [toolchain prefix]
# @DESCRIPTION:
# If gold linker is in use, force BFD
tc-ld-disable-gold() {
	tc-ld-is-gold "$@" && tc-ld-force-bfd "$@"
}

# @FUNCTION: tc-ld-force-bfd
# @USAGE: [toolchain prefix]
# @DESCRIPTION:
# If gold or lld linker is in use, force BFD and update env flags
tc-ld-force-bfd() {
	if ! tc-ld-is-gold "$@" && ! tc-ld-is-lld "$@" ; then
		return
	fi

	log_warn "Forcing usage of the BFD linker"

	local ld=$(unset LD; tc-getLD "$@")
	local bfd_ld="${ld}.bfd"
	local path_ld=$(type -P "${bfd_ld}" 2>/dev/null)
	[[ -e ${path_ld} ]] && export LD=${bfd_ld}

	if tc-is-gcc || tc-is-clang ; then
		export LDFLAGS="${LDFLAGS} -fuse-ld=bfd"
	fi
}

# @FUNCTION: _tc-has-openmp
# @INTERNAL
# @USAGE: [toolchain prefix]
# Checks if the toolchain supports OpenMP
_tc-has-openmp() {
	local base="${T}/test-tc-openmp"
	cat <<-EOF > "${base}.c"
	#include <omp.h>
	int main(void) {
		int nthreads, tid, ret = 0;
		#pragma omp parallel private(nthreads, tid)
		{
		tid = omp_get_thread_num();
		nthreads = omp_get_num_threads(); ret += tid + nthreads;
		}
		return ret;
	}
	EOF
	$(tc-getCC "$@") -fopenmp "${base}.c" -o "${base}" >&/dev/null
	local ret=$?
	rm -f "${base}"*
	return ${ret}
}

# @FUNCTION: tc-check-openmp
# Tests for OpenMP support, fails with log if missing
tc-check-openmp() {
	if ! _tc-has-openmp; then
		log_err "Your current compiler does not support OpenMP"

		if tc-is-gcc; then
			log_err "Enable OpenMP support by building app-build/gcc with USE=\"openmp\""
		elif tc-is-clang; then
			log_err "OpenMP support in app-build/clang is provided by lib-core/libomp"
		fi

		die "Active compiler does not have required support for OpenMP"
	fi
}

# @FUNCTION: tc-has-tls
# @USAGE: [-s|-c|-l] [toolchain prefix]
# Checks for thread-local storage support
tc-has-tls() {
	local base="${T}/test-tc-tls"
	cat <<-EOF > "${base}.c"
	int foo(int *i) {
		static __thread int j = 0;
		return *i ? j : *i;
	}
	EOF

	local flags
	case $1 in
		-s) flags="-S";;
		-c) flags="-c";;
		-l) ;;
		-*) log_err "Usage: tc-has-tls [-c|-l] [toolchain prefix]"; die;;
	esac

	: "${flags:=-fPIC -shared -Wl,-z,defs}"
	[[ $1 == -* ]] && shift
	$(tc-getCC "$@") ${flags} "${base}.c" -o "${base}" >&/dev/null
	local ret=$?
	rm -f "${base}"*
	return ${ret}
}

# @FUNCTION: tc-ninja_magic_to_arch
# Only supports amd64 and arm64, everything else is unknown
tc-ninja_magic_to_arch() {
	local type=$1
	local host=$2
	[[ -z ${host} ]] && host=${CTARGET:-${CHOST}}

	case ${host} in
		aarch64*)  echo arm64 ;;
		x86_64*)   [[ ${type} == "kern" ]] && echo x86 || echo amd64 ;;
		*)         echo unknown ;;
	esac
}
tc-arch-kernel() { tc-ninja_magic_to_arch kern "$@"; }
tc-arch()        { tc-ninja_magic_to_arch portage "$@"; }

# @FUNCTION: tc-endian
# Returns 'little' for amd64 and arm64, else wtf
tc-endian() {
	local host=$1
	[[ -z ${host} ]] && host=${CTARGET:-${CHOST}}
	host=${host%%-*}

	case ${host} in
		aarch64*|x86_64*) echo little ;;
		*)                echo wtf ;;
	esac
}

# @FUNCTION: tc-get-compiler-type
# Detects compiler: gcc, clang, or unknown
tc-get-compiler-type() {
	local code='
#if defined(__clang__)
	HAVE_CLANG
#elif defined(__GNUC__)
	HAVE_GCC
#endif
'
	local res=$($(tc-getCPP "$@") -E -P - <<<"${code}")

	case ${res} in
		*HAVE_CLANG*) echo clang ;;
		*HAVE_GCC*)   echo gcc ;;
		*)            echo unknown ;;
	esac
}

tc-is-gcc()   { [[ $(tc-get-compiler-type) == gcc ]]; }
tc-is-clang() { [[ $(tc-get-compiler-type) == clang ]]; }

# Internal: Query compiler for version info
_gcc_fullversion() {
	local ver="$1"; shift
	set -- $($(tc-getCPP "$@") -E -P - <<<"__GNUC__ __GNUC_MINOR__ __GNUC_PATCHLEVEL__")
	eval echo "${ver}"
}
gcc-fullversion()     { _gcc_fullversion '$1.$2.$3' "$@"; }
gcc-version()         { _gcc_fullversion '$1.$2' "$@"; }
gcc-major-version()   { _gcc_fullversion '$1' "$@"; }
gcc-minor-version()   { _gcc_fullversion '$2' "$@"; }
gcc-micro-version()   { _gcc_fullversion '$3' "$@"; }

_clang_fullversion() {
	local ver="$1"; shift
	set -- $($(tc-getCPP "$@") -E -P - <<<"__clang_major__ __clang_minor__ __clang_patchlevel__")
	eval echo "${ver}"
}
clang-fullversion()   { _clang_fullversion '$1.$2.$3' "$@"; }
clang-version()       { _clang_fullversion '$1.$2' "$@"; }
clang-major-version() { _clang_fullversion '$1' "$@"; }
clang-minor-version() { _clang_fullversion '$2' "$@"; }
clang-micro-version() { _clang_fullversion '$3' "$@"; }

_gcc-install-dir() {
	echo "$(LC_ALL=C $(tc-getCC) -print-search-dirs 2>/dev/null | awk '$1=="install:" {print $2}')"
}
_gcc-specs-exists() {
	[[ -f $(_gcc-install-dir)/$1 ]]
}
_gcc-specs-directive_raw() {
	local cc=$(tc-getCC)
	local specfiles=$(LC_ALL=C ${cc} -v 2>&1 | awk '$1=="Reading" {print $NF}')
	${cc} -dumpspecs 2>/dev/null | cat - ${specfiles} | awk -v directive=$1 '
BEGIN	{ pspec=""; spec=""; outside=1 }
$1=="*"directive":"  { pspec=spec; spec=""; outside=0; next }
	outside || NF==0 || ( substr($1,1,1)=="*" && substr($1,length($1),1)==":" ) { outside=1; next }
	spec=="" && substr($0,1,1)=="+" { spec=pspec " " substr($0,2); next }
	{ spec=spec $0 }
END	{ print spec }'
	return 0
}
gcc-specs-directive() {
	local directive subdname subdirective
	directive="$(_gcc-specs-directive_raw $1)"
	while [[ ${directive} == *%\(*\)* ]]; do
		subdname=${directive/*%\(}
		subdname=${subdname/\)*}
		subdirective="$(_gcc-specs-directive_raw ${subdname})"
		directive="${directive//\%(${subdname})/${subdirective}}"
	done
	echo "${directive}"
	return 0
}
gcc-specs-relro() {
	local directive
	directive=$(gcc-specs-directive link_command)
	[[ "${directive/\{!norelro:}" != "${directive}" ]]
}
gcc-specs-now() {
	local directive
	directive=$(gcc-specs-directive link_command)
	[[ "${directive/\{!nonow:}" != "${directive}" ]]
}
gcc-specs-pie() {
	local directive
	directive=$(gcc-specs-directive cc1)
	[[ "${directive/\{!nopie:}" != "${directive}" ]]
}
gcc-specs-ssp() {
	local directive
	directive=$(gcc-specs-directive cc1)
	[[ "${directive/\{!fno-stack-protector:}" != "${directive}" ]]
}
gcc-specs-ssp-to-all() {
	local directive
	directive=$(gcc-specs-directive cc1)
	[[ "${directive/\{!fno-stack-protector-all:}" != "${directive}" ]]
}
gcc-specs-nostrict() {
	local directive
	directive=$(gcc-specs-directive cc1)
	[[ "${directive/\{!fstrict-overflow:}" != "${directive}" ]]
}
gcc-specs-stack-check() {
	local directive
	directive=$(gcc-specs-directive cc1)
	[[ "${directive/\{!fno-stack-check:}" != "${directive}" ]]
}

# @FUNCTION: tc-enables-cxx-assertions
# Returns true if assertions are enabled in the C++ stdlib
tc-enables-cxx-assertions() {
	tc-cpp-is-true "defined(_GLIBCXX_ASSERTIONS) || defined(_LIBCPP_ENABLE_ASSERTIONS) || defined(_LIBCPP_ENABLE_HARDENED_MODE)" ${CPPFLAGS} ${CXXFLAGS}
}
# @FUNCTION: tc-enables-pie
# Returns true if compiler generates position-independent code (PIC)
tc-enables-pie() {
	tc-cpp-is-true "defined(__PIE__)" ${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}
}
# @FUNCTION: tc-enables-fortify-source
# Returns true if compiler enables fortification (FORTIFY_SOURCE)
tc-enables-fortify-source() {
	tc-cpp-is-true "defined(_FORTIFY_SOURCE)" ${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}
}
# @FUNCTION: tc-enables-ssp
# Returns true if compiler enables stack protector (any level)
tc-enables-ssp() {
	tc-cpp-is-true "defined(__SSP__) || defined(__SSP_STRONG__) || defined(__SSP_ALL__)" ${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}
}
# @FUNCTION: tc-enables-ssp-strong
# Returns true if compiler enables -fstack-protector-strong or -all
tc-enables-ssp-strong() {
	tc-cpp-is-true "defined(__SSP_STRONG__) || defined(__SSP_ALL__)" ${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}
}
# @FUNCTION: tc-enables-ssp-all
# Returns true if compiler enables -fstack-protector-all
tc-enables-ssp-all() {
	tc-cpp-is-true "defined(__SSP_ALL__)" ${CPPFLAGS} ${CFLAGS} ${CXXFLAGS}
}

# @FUNCTION: gen_usr_ldscript
# @USAGE: [-a] <list of libs>
# This function is deprecated. Use usr-ldscript.eclass instead.
gen_usr_ldscript() {
	log_warn "${FUNCNAME}: Please migrate to usr-ldscript.eclass"

	local lib libdir=lib output_format="" auto=false suffix=$(get_libname)
	[[ -z ${ED+set} ]] && local ED=${D%/}${EPREFIX}/

	tc-is-static-only && return

	dodir /usr/${libdir}

	if [[ $1 == "-a" ]]; then
		auto=true
		shift
		dodir /${libdir}
	fi

	local flags=( ${CFLAGS} ${LDFLAGS} -Wl,--verbose )
	if $(tc-getLD) --version | grep -q 'GNU gold'; then
		local d="${T}/bfd-linker"
		mkdir -p "${d}"
		ln -sf $(type -P ${CHOST}-ld.bfd) "${d}"/ld
		flags+=( -B"${d}" )
	fi
	output_format=$($(tc-getCC) "${flags[@]}" 2>&1 | sed -n 's/^OUTPUT_FORMAT("\([^"]*\)",.*/\1/p')
	[[ -n ${output_format} ]] && output_format="OUTPUT_FORMAT ( ${output_format} )"

	for lib in "$@"; do
		local tlib
		if ${auto}; then
			lib="lib${lib}${suffix}"
		else
			[[ -r ${ED}/${libdir}/${lib} ]] || continue
		fi

		if ${auto}; then
			tlib=$(scanelf -qF'%S#F' "${ED}"/usr/${libdir}/${lib})
			[[ -z ${tlib} ]] && die "unable to read SONAME from ${lib}"
			mv "${ED}"/usr/${libdir}/${lib}* "${ED}"/${libdir}/ || die
			if [[ ${tlib} != ${lib}* ]]; then
				mv "${ED}"/usr/${libdir}/${tlib}* "${ED}"/${libdir}/ || die
			fi
			rm -f "${ED}"/${libdir}/${lib}
		else
			tlib=${lib}
		fi

		cat > "${ED}/usr/${libdir}/${lib}" <<-END_LDSCRIPT
		/* GNU ld script for split-usr system, see bug #4411 */
		${output_format}
		GROUP ( ${EPREFIX}/${libdir}/${tlib} )
		END_LDSCRIPT

		fperms a+x "/usr/${libdir}/${lib}" || die "could not change perms on ${lib}"
	done
}

# @FUNCTION: tc-get-cxx-stdlib
# Attempts to identify the C++ standard library used by the compiler.
tc-get-cxx-stdlib() {
	local code='#include <ciso646>
#if defined(_LIBCPP_VERSION)
	HAVE_LIBCXX
#elif defined(__GLIBCXX__)
	HAVE_LIBSTDCPP
#endif
'
	local res=$(
		$(tc-getCXX) ${CPPFLAGS} ${CXXFLAGS} -x c++ -E -P - <<<"${code}" 2>/dev/null
	)
	case ${res} in
		*HAVE_LIBCXX*)    echo libc++ ;;
		*HAVE_LIBSTDCPP*) echo libstdc++ ;;
		*) return 1 ;;
	esac
	return 0
}

# @FUNCTION: tc-get-c-rtlib
# Attempts to identify the runtime used by the C/C++ compiler.
tc-get-c-rtlib() {
	local res=$(
		$(tc-getCC) ${CPPFLAGS} ${CFLAGS} ${LDFLAGS} \
			-print-libgcc-file-name 2>/dev/null
	)
	case ${res} in
		*libclang_rt*) echo compiler-rt ;;
		*libgcc*)      echo libgcc ;;
		*)             return 1 ;;
	esac
	return 0
}

# @FUNCTION: tc-get-ptr-size
# Returns pointer size in bytes for CHOST (e.g. 8)
tc-get-ptr-size() {
	$(tc-getCPP) -P - <<< __SIZEOF_POINTER__ || die "Could not determine CHOST pointer size"
}

# @FUNCTION: tc-get-build-ptr-size
# Returns pointer size in bytes for CBUILD (e.g. 8)
tc-get-build-ptr-size() {
	$(tc-getBUILD_CPP) -P - <<< __SIZEOF_POINTER__ || die "Could not determine CBUILD pointer size"
}

# @FUNCTION: tc-is-lto
# Returns true if using LTO, false otherwise
tc-is-lto() {
	local f="${T}/test-lto.o"
	case $(tc-get-compiler-type) in
		clang)
			$(tc-getCC) ${CFLAGS} -c -o "${f}" -x c - <<<"" || die
			llvm-bcanalyzer "${f}" &>/dev/null && return 0
			;;
		gcc)
			$(tc-getCC) ${CFLAGS} -c -o "${f}" -x c - <<<"" || die
			[[ $($(tc-getREADELF) -S "${f}") == *.gnu.lto* ]] && return 0
			;;
	esac
	return 1
}

fi

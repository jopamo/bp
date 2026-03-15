# Distributed under the terms of the GNU General Public License v2

# @ECLASS: lto-policy.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Policy driven LTO setup and archive sanitizing
# @DESCRIPTION:
# Define one LTO policy for setup, sanitize, and assert phases

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_LTO_POLICY_ECLASS:-} ]] ; then
_LTO_POLICY_ECLASS=1

inherit flag-o-matic toolchain-funcs

: "${LTO_POLICY_MODE:=none}"
: "${LTO_POLICY_DENYLIST:=}"
: "${LTO_POLICY_USE_FLAG:=lto}"
: "${LTO_POLICY_STRICT:=1}"
: "${LTO_POLICY_ENFORCE_LLVM_TOOLS:=1}"
: "${LTO_POLICY_FORCE_LLD_WITH_THIN:=1}"
: "${LTO_POLICY_CACHE_DIR:=}"
: "${LTO_POLICY_CACHE_POLICY:=cache_size_bytes=2147483648:prune_interval=86400}"
: "${LTO_POLICY_IR_ALLOW:=}"

_LTO_POLICY_ACTIVE=0

_lto-policy-resolve-inputs() {
	local caller=$1
	local -n inputs_ref=$2
	shift 2

	if [[ ${#} -eq 0 ]]; then
		[[ -n ${ED-} ]] || die "${caller}: path arguments required when ED is unset"
		inputs_ref=( "${ED}" )
		return
	fi

	inputs_ref=( "$@" )
}

_lto-policy-strip-mode() {
	case $(tc-get-compiler-type) in
		gcc) printf '%s\n' gnu ;;
		clang) printf '%s\n' llvm ;;
		*) return 1 ;;
	esac
}

_lto-policy-detect-strip-mode() {
	local fallback_mode=$1
	shift

	local file readelf_cmd nm_cmd readelf_out nm_out
	local has_llvm=0 has_gnu=0

	if declare -F tc-getREADELF >/dev/null; then
		readelf_cmd=$(tc-getREADELF)
	else
		readelf_cmd=$(command -v readelf || true)
	fi
	if declare -F tc-getNM >/dev/null; then
		nm_cmd=$(tc-getNM)
	else
		nm_cmd=$(command -v nm || true)
	fi

	for file in "$@"; do
		if [[ -n ${readelf_cmd} ]]; then
			readelf_out=$("${readelf_cmd}" -SW "${file}" 2>/dev/null || true)
			grep -Eq '[[:space:]]\.llvmbc([[:space:]]|$)|\.llvm\.lto' <<< "${readelf_out}" && has_llvm=1
			grep -Eq '\.gnu\.lto_' <<< "${readelf_out}" && has_gnu=1
		fi

		if [[ -n ${nm_cmd} ]]; then
			nm_out=$("${nm_cmd}" -a "${file}" 2>/dev/null || true)
			grep -Eq '(__gnu_lto_v1|__gnu_lto_slim)' <<< "${nm_out}" && has_gnu=1
		fi

		[[ ${has_llvm} == 1 && ${has_gnu} == 1 ]] && break
	done

	if [[ ${has_llvm} == 1 && ${has_gnu} == 1 ]]; then
		printf '%s\n' mixed
	elif [[ ${has_llvm} == 1 ]]; then
		printf '%s\n' llvm
	elif [[ ${has_gnu} == 1 ]]; then
		printf '%s\n' gnu
	else
		printf '%s\n' "${fallback_mode}"
	fi
}

_lto-policy-enable-fat-objects() {
	local -a fat_flags=( $(test-flags-CC -ffat-lto-objects) )
	[[ ${#fat_flags[@]} -gt 0 ]] && append-flags "${fat_flags[@]}"
}

_lto-policy-strip-bytecode() {
	local input
	local -a inputs=()

	if [[ ${#} -eq 0 ]]; then
		if in_iuse static-libs && ! use static-libs ; then
			return
		fi
	fi

	_lto-policy-resolve-inputs "${FUNCNAME[0]}" inputs "$@"

	for input in "${inputs[@]}" ; do
		[[ -e ${input} ]] || die "lto: missing path ${input}"
	done

	local -a files=()
	local -a found=()
	for input in "${inputs[@]}" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f \( -name '*.a' -o -name '*.o' \) -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} ]]; then
			case ${input} in
				*.a|*.o) files+=( "${input}" ) ;;
			esac
		fi
	done

	[[ ${#files[@]} -gt 0 ]] || return

	local strip_mode
	strip_mode=$(_lto-policy-strip-mode) || return
	strip_mode=$(_lto-policy-detect-strip-mode "${strip_mode}" "${files[@]}")

	local file
	local -a objcopy_cmd=()
	if [[ ${strip_mode} == llvm || ${strip_mode} == mixed ]]; then
		local -a llvm_objcopy_cmd=( $(tc-getPROG LLVM_OBJCOPY llvm-objcopy) )
		if command -v "${llvm_objcopy_cmd[0]}" >/dev/null 2>&1; then
			objcopy_cmd=( "${llvm_objcopy_cmd[@]}" )
		fi
	fi
	[[ ${#objcopy_cmd[@]} -gt 0 ]] || objcopy_cmd=( $(tc-getOBJCOPY) )
	command -v "${objcopy_cmd[0]}" >/dev/null || die "lto: unable to find ${objcopy_cmd[0]}"

	case ${strip_mode} in
		gnu)
			local -a strip_cmd=( $(tc-getSTRIP) )
			command -v "${strip_cmd[0]}" >/dev/null || die "lto: unable to find ${strip_cmd[0]}"
			for file in "${files[@]}" ; do
				if "${objcopy_cmd[@]}" \
					--remove-section=.gnu.lto_* \
					--remove-section=.gnu.debuglto_* \
					--remove-section=.llvmbc \
					--remove-section=.llvm.lto \
					--strip-symbol=__gnu_lto_v1 \
					--strip-symbol=__gnu_lto_slim \
					"${file}" >/dev/null 2>&1; then
					continue
				fi

				"${strip_cmd[@]}" \
					-R .gnu.lto_* \
					-R .gnu.debuglto_* \
					-R .llvmbc \
					-R .llvm.lto \
					-N __gnu_lto_v1 \
					-N __gnu_lto_slim \
					"${file}" || die "lto: stripping bytecode in ${file} failed"
			done
			;;
		llvm)
			local -a llvm_strip_cmd=( $(tc-getPROG LLVM_BITCODE_STRIP llvm-bitcode-strip) )
			local have_llvm_strip=0
			command -v "${llvm_strip_cmd[0]}" >/dev/null 2>&1 && have_llvm_strip=1

			for file in "${files[@]}" ; do
				if "${objcopy_cmd[@]}" \
					--remove-section=.llvmbc \
					--remove-section=.llvm.lto \
					--remove-section=.gnu.lto_* \
					--remove-section=.gnu.debuglto_* \
					"${file}" >/dev/null 2>&1; then
					continue
				fi

				if [[ ${have_llvm_strip} == 1 ]] && "${llvm_strip_cmd[@]}" \
					-r "${file}" \
					-o "${file}" >/dev/null 2>&1; then
					continue
				fi

				die "lto: stripping bytecode in ${file} failed"
			done
			;;
		mixed)
			local -a strip_cmd=( $(tc-getSTRIP) )
			local -a llvm_strip_cmd=( $(tc-getPROG LLVM_BITCODE_STRIP llvm-bitcode-strip) )
			local have_strip=0 have_llvm_strip=0
			command -v "${strip_cmd[0]}" >/dev/null 2>&1 && have_strip=1
			command -v "${llvm_strip_cmd[0]}" >/dev/null 2>&1 && have_llvm_strip=1

			for file in "${files[@]}" ; do
				if "${objcopy_cmd[@]}" \
					--remove-section=.gnu.lto_* \
					--remove-section=.gnu.debuglto_* \
					--remove-section=.llvmbc \
					--remove-section=.llvm.lto \
					--strip-symbol=__gnu_lto_v1 \
					--strip-symbol=__gnu_lto_slim \
					"${file}" >/dev/null 2>&1; then
					continue
				fi

				if [[ ${have_strip} == 1 ]] && "${strip_cmd[@]}" \
					-R .gnu.lto_* \
					-R .gnu.debuglto_* \
					-R .llvmbc \
					-R .llvm.lto \
					-N __gnu_lto_v1 \
					-N __gnu_lto_slim \
					"${file}" >/dev/null 2>&1; then
					continue
				fi

				if [[ ${have_llvm_strip} == 1 ]] && "${llvm_strip_cmd[@]}" \
					-r "${file}" \
					-o "${file}" >/dev/null 2>&1; then
					continue
				fi

				die "lto: stripping bytecode in ${file} failed"
			done
			;;
	esac
}

_lto-policy-should-sanitize() {
	[[ ${_LTO_POLICY_ACTIVE} == 1 ]] && return 0
	tc-is-lto
}

_lto-policy-pkg-key() {
	local category=${CATEGORY-}
	local pn=${PN-}

	if [[ -n ${category} && -n ${pn} ]]; then
		echo "${category}/${pn}"
		return
	fi

	echo "${PF:-unknown}"
}

_lto-policy-match-any() {
	local needle=$1
	local re
	for re in ${*:2}; do
		[[ ${needle} =~ ${re} ]] && return 0
	done
	return 1
}

_lto-policy-is-denied() {
	local pkg
	pkg=$(_lto-policy-pkg-key)
	_lto-policy-match-any "${pkg}" ${LTO_POLICY_DENYLIST-}
}

_lto-policy-export-llvm-tools() {
	[[ ${LTO_POLICY_ENFORCE_LLVM_TOOLS:-1} == 1 ]] || return
	[[ $(tc-get-compiler-type) == clang ]] || return

	tc-getPROG AR llvm-ar >/dev/null
	tc-getPROG RANLIB llvm-ranlib >/dev/null
	tc-getPROG NM llvm-nm >/dev/null
	tc-getPROG STRIP llvm-strip >/dev/null

	local t
	for t in AR RANLIB NM STRIP; do
		local cmd=${!t%% *}
		if ! command -v "${cmd}" >/dev/null; then
			if [[ ${LTO_POLICY_STRICT:-1} == 1 ]]; then
				die "lto: ${t}=${cmd} not found"
			fi
			ewarn "lto: ${t}=${cmd} not found"
		fi
	done
}

_lto-policy-enable-flag() {
	local flag=$1
	local -a got=( $(test-flags-CC "${flag}") )
	if [[ ${#got[@]} -eq 0 ]]; then
		if [[ ${LTO_POLICY_STRICT:-1} == 1 ]]; then
			die "lto: compiler rejected ${flag}"
		fi
		ewarn "lto: compiler rejected ${flag}, skipping"
		return 1
	fi

	append-flags "${got[@]}"
	append-ldflags "${got[@]}"
	return 0
}

_lto-policy-enable-thin-cache() {
	if [[ -z ${LTO_POLICY_CACHE_DIR-} ]]; then
		[[ -n ${T-} ]] || die "lto: thin cache mode requires T or LTO_POLICY_CACHE_DIR"
		LTO_POLICY_CACHE_DIR=${T}/thinlto-cache
	fi
	mkdir -p "${LTO_POLICY_CACHE_DIR}" || die "lto: unable to create cache dir ${LTO_POLICY_CACHE_DIR}"

	case $(tc-get-compiler-type) in
		clang)
			append-ldflags "-Wl,--thinlto-cache-dir=${LTO_POLICY_CACHE_DIR}"
			append-ldflags "-Wl,--thinlto-cache-policy=${LTO_POLICY_CACHE_POLICY:-cache_size_bytes=2147483648:prune_interval=86400}"
			if [[ ${LTO_POLICY_FORCE_LLD_WITH_THIN:-1} == 1 && ${LDFLAGS-} != *-fuse-ld=* ]]; then
				append-ldflags -fuse-ld=lld
			fi
			;;
		gcc)
			if [[ ${LTO_POLICY_STRICT:-1} == 1 ]]; then
				die "lto: thin cache mode needs clang"
			fi
			ewarn "lto: thin cache mode is not supported by this compiler"
			;;
	esac
}

_lto-policy-mode-none() {
	filter-lto
	_LTO_POLICY_ACTIVE=0
}

_lto-policy-mode-full() {
	_lto-policy-enable-flag -flto || return
	_LTO_POLICY_ACTIVE=1
}

_lto-policy-mode-thin() {
	if ! _lto-policy-enable-flag -flto=thin; then
		if [[ ${LTO_POLICY_STRICT:-1} == 1 ]]; then
			return 1
		fi
		_lto-policy-enable-flag -flto || return
	fi
	_LTO_POLICY_ACTIVE=1
}

_lto-policy-mode-thin-cache() {
	_lto-policy-mode-thin || return
	_lto-policy-enable-thin-cache
	_LTO_POLICY_ACTIVE=1
}

_lto-policy-mode-fat-strip() {
	_lto-policy-enable-flag -flto || return
	_lto-policy-enable-fat-objects
	_LTO_POLICY_ACTIVE=1
}

# @FUNCTION: lto-setup
# @DESCRIPTION:
# Resolve LTO policy and export stable toolchain knobs
lto-setup() {
	local mode=${LTO_POLICY_MODE:-none}
	local use_flag=${LTO_POLICY_USE_FLAG-}

	case ${mode} in
		none|full|thin|thin+cache|fat+strip) ;;
		*) die "lto-setup: invalid LTO_POLICY_MODE=${mode}" ;;
	esac

	if _lto-policy-is-denied; then
		einfo "lto: policy denylist matched $(_lto-policy-pkg-key), disabling LTO"
		_lto-policy-mode-none
		return
	fi

	if [[ -n ${use_flag} ]] && in_iuse "${use_flag}" && ! use "${use_flag}"; then
		einfo "lto: USE=${use_flag} is disabled, skipping LTO"
		_lto-policy-mode-none
		return
	fi

	case ${mode} in
		none) _lto-policy-mode-none ;;
		full) _lto-policy-mode-full ;;
		thin) _lto-policy-mode-thin ;;
		thin+cache) _lto-policy-mode-thin-cache ;;
		fat+strip) _lto-policy-mode-fat-strip ;;
	esac

	if [[ ${_LTO_POLICY_ACTIVE} == 1 ]]; then
		_lto-policy-export-llvm-tools
	fi
}

_lto-policy-collect-archives() {
	local caller=$1
	local -n files_ref=$2
	shift 2

	local input
	local -a inputs=()
	local -a found=()

	files_ref=()
	_lto-policy-resolve-inputs "${caller}" inputs "$@"

	for input in "${inputs[@]}" ; do
		[[ -e ${input} ]] || die "${caller}: missing path ${input}"
	done

	for input in "${inputs[@]}" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -name '*.a' -print0)
			files_ref+=( "${found[@]}" )
		elif [[ -f ${input} && ${input} == *.a ]]; then
			files_ref+=( "${input}" )
		fi
	done
}

_lto-policy-relpath() {
	local file=$1
	local root=${ED-}

	root=${root%/}
	if [[ -n ${root} && ${file} == "${root}"/* ]]; then
		printf '%s\n' "${file#${root}}"
		return
	fi

	printf '%s\n' "${file}"
}

# @FUNCTION: lto-postinstall-sanitize
# @USAGE: [path] [more]
# @DESCRIPTION:
# Apply post install archive cleanup per policy mode
lto-postinstall-sanitize() {
	_lto-policy-should-sanitize || return

	local -a inputs=()
	local -a archives=()
	_lto-policy-resolve-inputs "${FUNCNAME[0]}" inputs "$@"
	_lto-policy-collect-archives "${FUNCNAME[0]}" archives "${inputs[@]}"
	[[ ${#archives[@]} -gt 0 ]] || return

	if [[ ${LTO_POLICY_MODE:-none} == fat+strip || ${_LTO_POLICY_ACTIVE} != 1 ]]; then
		_lto-policy-strip-bytecode "${inputs[@]}"
	fi

	local ranlib_cmd
	ranlib_cmd=$(tc-getRANLIB)
	local archive
	for archive in "${archives[@]}" ; do
		"${ranlib_cmd}" "${archive}" || die "lto: ranlib failed for ${archive}"
	done
}

_lto-policy-ir-allowed() {
	local rel=$1
	local re
	for re in ${LTO_POLICY_IR_ALLOW-}; do
		[[ ${rel} =~ ${re} ]] && return 0
	done
	return 1
}

_lto-policy-has-ir() {
	local archive=$1
	local readelf_cmd nm_cmd
	local readelf_out nm_out

	if declare -F tc-getREADELF >/dev/null; then
		readelf_cmd=$(tc-getREADELF)
	else
		readelf_cmd=$(command -v readelf || true)
	fi
	if [[ -n ${readelf_cmd} ]]; then
		readelf_out=$("${readelf_cmd}" -SW "${archive}" 2>/dev/null || true)
		if grep -Eq '\.gnu\.lto_|[[:space:]]\.llvmbc([[:space:]]|$)|\.llvm\.lto' <<< "${readelf_out}"; then
			return 0
		fi
	fi

	if declare -F tc-getNM >/dev/null; then
		nm_cmd=$(tc-getNM)
	else
		nm_cmd=$(command -v nm || true)
	fi
	if [[ -n ${nm_cmd} ]]; then
		nm_out=$("${nm_cmd}" -a "${archive}" 2>/dev/null || true)
		grep -Eq '(__gnu_lto_v1|__gnu_lto_slim)' <<< "${nm_out}" && return 0
	fi

	return 1
}

# @FUNCTION: lto-assert-clean-ir
# @USAGE: [path] [more]
# @DESCRIPTION:
# Fail if installed static archives still carry LTO IR payloads
lto-assert-clean-ir() {
	local -a archives=()
	_lto-policy-collect-archives "${FUNCNAME[0]}" archives "$@"
	[[ ${#archives[@]} -gt 0 ]] || return

	local -i failures=0
	local archive rel
	for archive in "${archives[@]}" ; do
		rel=$(_lto-policy-relpath "${archive}")
		if _lto-policy-has-ir "${archive}"; then
			if _lto-policy-ir-allowed "${rel}"; then
				einfo "lto: allowlisted IR in ${rel}"
				continue
			fi
			eerror "lto: IR payload found in ${rel}"
			(( failures += 1 ))
		fi
	done

	[[ ${failures} -eq 0 ]] || die "lto-assert-clean-ir: ${failures} archive(s) contain IR"
}

fi

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

if [[ -z ${_LTO_POLICY_ECLASS} ]] ; then
_LTO_POLICY_ECLASS=1

inherit dot-a flag-o-matic toolchain-funcs

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

_lto-policy-pkg-key() {
	if [[ -n ${CATEGORY} && -n ${PN} ]]; then
		echo "${CATEGORY}/${PN}"
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
	_lto-policy-match-any "${pkg}" ${LTO_POLICY_DENYLIST}
}

_lto-policy-export-llvm-tools() {
	[[ ${LTO_POLICY_ENFORCE_LLVM_TOOLS} == 1 ]] || return
	[[ $(tc-get-compiler-type) == clang ]] || return

	tc-getPROG AR llvm-ar >/dev/null
	tc-getPROG RANLIB llvm-ranlib >/dev/null
	tc-getPROG NM llvm-nm >/dev/null
	tc-getPROG STRIP llvm-strip >/dev/null

	local t
	for t in AR RANLIB NM STRIP; do
		local cmd=${!t%% *}
		if ! command -v "${cmd}" >/dev/null; then
			if [[ ${LTO_POLICY_STRICT} == 1 ]]; then
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
		if [[ ${LTO_POLICY_STRICT} == 1 ]]; then
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
	[[ -n ${LTO_POLICY_CACHE_DIR} ]] || LTO_POLICY_CACHE_DIR=${T}/thinlto-cache
	mkdir -p "${LTO_POLICY_CACHE_DIR}" || die "lto: unable to create cache dir ${LTO_POLICY_CACHE_DIR}"

	case $(tc-get-compiler-type) in
		clang)
			append-ldflags "-Wl,--thinlto-cache-dir=${LTO_POLICY_CACHE_DIR}"
			append-ldflags "-Wl,--thinlto-cache-policy=${LTO_POLICY_CACHE_POLICY}"
			if [[ ${LTO_POLICY_FORCE_LLD_WITH_THIN} == 1 && ${LDFLAGS} != *-fuse-ld=* ]]; then
				append-ldflags -fuse-ld=lld
			fi
			;;
		gcc)
			if [[ ${LTO_POLICY_STRICT} == 1 ]]; then
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
		if [[ ${LTO_POLICY_STRICT} == 1 ]]; then
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
	lto-guarantee-fat
	_LTO_POLICY_ACTIVE=1
}

# @FUNCTION: lto-setup
# @DESCRIPTION:
# Resolve LTO policy and export stable toolchain knobs
lto-setup() {
	case ${LTO_POLICY_MODE} in
		none|full|thin|thin+cache|fat+strip) ;;
		*) die "lto-setup: invalid LTO_POLICY_MODE=${LTO_POLICY_MODE}" ;;
	esac

	if _lto-policy-is-denied; then
		einfo "lto: policy denylist matched $(_lto-policy-pkg-key), disabling LTO"
		_lto-policy-mode-none
		return
	fi

	if [[ -n ${LTO_POLICY_USE_FLAG} ]] && in_iuse "${LTO_POLICY_USE_FLAG}" && ! use "${LTO_POLICY_USE_FLAG}"; then
		einfo "lto: USE=${LTO_POLICY_USE_FLAG} is disabled, skipping LTO"
		_lto-policy-mode-none
		return
	fi

	case ${LTO_POLICY_MODE} in
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

_lto-policy-find-archives() {
	local input
	local -a files=()
	local -a found=()

	if [[ ${#} -eq 0 ]]; then
		set -- "${ED}"
	fi

	for input in "$@" ; do
		[[ -e ${input} ]] || die "lto: missing path ${input}"
	done

	for input in "$@" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -name '*.a' -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} && ${input} == *.a ]]; then
			files+=( "${input}" )
		fi
	done

	echo "${files[@]}"
}

# @FUNCTION: lto-postinstall-sanitize
# @USAGE: [path] [more]
# @DESCRIPTION:
# Apply post install archive cleanup per policy mode
lto-postinstall-sanitize() {
	[[ ${_LTO_POLICY_ACTIVE} == 1 ]] || return

	local -a archives=( $(_lto-policy-find-archives "$@") )
	[[ ${#archives[@]} -gt 0 ]] || return

	if [[ ${LTO_POLICY_MODE} == fat+strip ]]; then
		if [[ ${#} -eq 0 ]]; then
			strip-lto-bytecode "${ED}"
		else
			strip-lto-bytecode "$@"
		fi
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
	for re in ${LTO_POLICY_IR_ALLOW}; do
		[[ ${rel} =~ ${re} ]] && return 0
	done
	return 1
}

_lto-policy-has-ir() {
	local archive=$1
	grep -aEq '__gnu_lto_v1|\.gnu\.lto_|\.llvmbc|\.llvm' "${archive}"
}

# @FUNCTION: lto-assert-clean-ir
# @USAGE: [path] [more]
# @DESCRIPTION:
# Fail if installed static archives still carry LTO IR payloads
lto-assert-clean-ir() {
	local -a archives=( $(_lto-policy-find-archives "$@") )
	[[ ${#archives[@]} -gt 0 ]] || return

	local -i failures=0
	local archive rel
	for archive in "${archives[@]}" ; do
		rel=${archive#${ED}}
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

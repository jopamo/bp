# Distributed under the terms of the GNU General Public License v2

# @ECLASS: linker-policy.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Central linker policy helpers
# @DESCRIPTION:
# Predictable linker selection and link flag policy
# Setup is done in src_configure or earlier, assert is run after install

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_LINKER_POLICY_ECLASS} ]] ; then
_LINKER_POLICY_ECLASS=1

inherit flag-o-matic toolchain-funcs

: "${LP_MODE:=compat}"
: "${LP_ALLOW_AS_NEEDED_BREAKAGE:=}"
: "${LP_PREFER:=}"
: "${LP_ENABLE_GC_SECTIONS:=auto}"
: "${LP_ENABLE_ICF_SAFE:=auto}"
: "${LP_FORBID_BFD:=0}"
: "${LP_FORBID_LLD:=0}"
: "${LP_FORBID_MOLD:=0}"
: "${LP_REQUIRE_LINK_MAP:=0}"
: "${LP_ENFORCE_LLVM_TOOLS:=1}"

LP_LINKER=${LP_LINKER:-}

_lp-pkg-key() {
	if [[ -n ${CATEGORY} && -n ${PN} ]]; then
		echo "${CATEGORY}/${PN}"
		return
	fi

	echo "${PF:-unknown}"
}

_lp-match-any() {
	local needle=$1
	local re
	for re in ${*:2}; do
		[[ ${needle} =~ ${re} ]] && return 0
	done
	return 1
}

_lp-should-use-as-needed() {
	local pkg
	pkg=$(_lp-pkg-key)
	_lp-match-any "${pkg}" ${LP_ALLOW_AS_NEEDED_BREAKAGE} && return 1
	return 0
}

_lp-set-default-switches() {
	case ${LP_MODE} in
		strict|compat) ;;
		*) die "lp-setup: invalid LP_MODE=${LP_MODE}" ;;
	esac

	if [[ ${LP_ENABLE_GC_SECTIONS} == auto ]]; then
		if [[ ${LP_MODE} == strict ]]; then
			LP_ENABLE_GC_SECTIONS=1
		else
			LP_ENABLE_GC_SECTIONS=0
		fi
	fi

	if [[ ${LP_ENABLE_ICF_SAFE} == auto ]]; then
		if [[ ${LP_MODE} == strict ]]; then
			LP_ENABLE_ICF_SAFE=1
		else
			LP_ENABLE_ICF_SAFE=0
		fi
	fi
}

_lp-export-llvm-tool() {
	local var=$1
	local prog=$2
	local val cmd

	val=$(tc-getPROG "${var}" "${prog}")
	cmd=${val%% *}
	if ! command -v "${cmd}" >/dev/null; then
		if [[ ${LP_MODE} == strict ]]; then
			die "${var}=${cmd} not found"
		fi
		ewarn "${var}=${cmd} not found, keeping current tool"
		return 1
	fi

	return 0
}

_lp-align-llvm-tools() {
	[[ ${LP_ENFORCE_LLVM_TOOLS} == 1 ]] || return
	[[ $(tc-get-compiler-type) == clang ]] || return

	_lp-export-llvm-tool AR llvm-ar
	_lp-export-llvm-tool RANLIB llvm-ranlib
	_lp-export-llvm-tool NM llvm-nm
	_lp-export-llvm-tool STRIP llvm-strip
}

_lp-select-linker() {
	local linker=$1

	case ${linker} in
		bfd)
			[[ ${LP_FORBID_BFD} == 1 ]] && die "lp: bfd is forbidden"
			append-ldflags -fuse-ld=bfd
			LP_LINKER=bfd
			command -v ld.bfd >/dev/null && export LD=ld.bfd
			;;
		lld)
			[[ ${LP_FORBID_LLD} == 1 ]] && die "lp: lld is forbidden"
			append-ldflags -fuse-ld=lld
			LP_LINKER=lld
			command -v ld.lld >/dev/null && export LD=ld.lld
			_lp-align-llvm-tools
			;;
		mold)
			[[ ${LP_FORBID_MOLD} == 1 ]] && die "lp: mold is forbidden"
			append-ldflags -fuse-ld=mold
			LP_LINKER=mold
			if command -v ld.mold >/dev/null; then
				export LD=ld.mold
			elif command -v mold >/dev/null; then
				export LD=mold
			fi
			_lp-align-llvm-tools
			;;
		*) die "lp: unsupported linker ${linker}" ;;
	esac

	export LP_LINKER
}

# @FUNCTION: lp-use-bfd
# @DESCRIPTION:
# Force bfd and export stable linker state
lp-use-bfd() {
	_lp-select-linker bfd
}

# @FUNCTION: lp-use-lld
# @DESCRIPTION:
# Force lld and export stable linker state
lp-use-lld() {
	_lp-select-linker lld
}

# @FUNCTION: lp-use-mold
# @DESCRIPTION:
# Force mold and export stable linker state
lp-use-mold() {
	_lp-select-linker mold
}

# @FUNCTION: lp-setup
# @DESCRIPTION:
# Apply linker policy knobs and link hygiene flags
lp-setup() {
	_lp-set-default-switches

	case ${LP_PREFER} in
		'') ;;
		bfd|lld|mold) _lp-select-linker "${LP_PREFER}" ;;
		*) die "lp-setup: invalid LP_PREFER=${LP_PREFER}" ;;
	esac

	if [[ -z ${LP_LINKER} && ${LP_MODE} == strict ]]; then
		if command -v ld.mold >/dev/null; then
			_lp-select-linker mold
		elif command -v ld.lld >/dev/null; then
			_lp-select-linker lld
		else
			_lp-select-linker bfd
		fi
	fi

	if _lp-should-use-as-needed; then
		append-ldflags -Wl,--as-needed
	else
		einfo "lp: skipping --as-needed for $(_lp-pkg-key)"
	fi

	if [[ ${LP_ENABLE_GC_SECTIONS} == 1 ]]; then
		append-flags -ffunction-sections -fdata-sections
		append-ldflags -Wl,--gc-sections
	fi

	if [[ ${LP_ENABLE_ICF_SAFE} == 1 ]]; then
		append-ldflags -Wl,--icf=safe
	fi
}

_lp-detect-linker() {
	local file=$1
	local readelf_cmd strings_cmd comment blob

	readelf_cmd=$(tc-getREADELF)
	strings_cmd=$(tc-getSTRINGS)

	comment=$("${readelf_cmd}" -p .comment "${file}" 2>/dev/null || true)
	if echo "${comment}" | grep -Eqi 'mold'; then
		echo mold
		return
	fi
	if echo "${comment}" | grep -Eqi 'LLD'; then
		echo lld
		return
	fi
	if echo "${comment}" | grep -Eqi 'GNU gold'; then
		echo gold
		return
	fi
	if echo "${comment}" | grep -Eqi 'GNU ld|BFD'; then
		echo bfd
		return
	fi

	blob=$("${strings_cmd}" -a "${file}" 2>/dev/null || true)
	if echo "${blob}" | grep -Eqi 'mold'; then
		echo mold
		return
	fi
	if echo "${blob}" | grep -Eqi 'LLD'; then
		echo lld
		return
	fi
	if echo "${blob}" | grep -Eqi 'GNU gold'; then
		echo gold
		return
	fi
	if echo "${blob}" | grep -Eqi 'GNU ld|BFD'; then
		echo bfd
		return
	fi

	echo unknown
}

_lp-is-dynamic-target() {
	local file=$1
	local readelf_cmd etype
	readelf_cmd=$(tc-getREADELF)

	etype=$("${readelf_cmd}" -h "${file}" 2>/dev/null | awk '/Type:/ { print $2; exit }')
	[[ ${etype} == EXEC || ${etype} == DYN ]]
}

# @FUNCTION: lp-assert-linker
# @USAGE: [path] [more]
# @DESCRIPTION:
# Scan installed ELFs and enforce linker identity when detectable
lp-assert-linker() {
	local expected=${LP_LINKER:-${LP_PREFER}}
	local readelf_cmd
	readelf_cmd=$(tc-getREADELF)

	if [[ ${LP_REQUIRE_LINK_MAP} == 1 ]]; then
		ewarn "lp: LP_REQUIRE_LINK_MAP is set but map parsing is not implemented"
	fi

	if [[ ${#} -eq 0 ]]; then
		set -- "${ED}"
	fi

	local input
	for input in "$@" ; do
		[[ -e ${input} ]] || die "lp-assert-linker: missing path ${input}"
	done

	local -i failures=0 scanned=0
	local -a files=()
	local -a found=()
	for input in "$@" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} ]]; then
			files+=( "${input}" )
		fi
	done

	local file rel detected
	for file in "${files[@]}" ; do
		"${readelf_cmd}" -h "${file}" >/dev/null 2>&1 || continue
		_lp-is-dynamic-target "${file}" || continue
		(( scanned += 1 ))

		detected=$(_lp-detect-linker "${file}")
		rel=${file#${ED}}

		if [[ -n ${expected} && ${detected} != unknown && ${detected} != ${expected} ]]; then
			eerror "lp: ${rel}: expected ${expected}, detected ${detected}"
			(( failures += 1 ))
			continue
		fi

		if [[ ${LP_MODE} == strict && ${detected} == unknown ]]; then
			eerror "lp: ${rel}: linker could not be detected"
			(( failures += 1 ))
		fi
	done

	einfo "lp: scanned ${scanned} ELF files"
	[[ ${failures} -eq 0 ]] || die "lp-assert-linker: ${failures} violation(s)"
}

fi

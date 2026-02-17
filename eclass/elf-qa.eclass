# Distributed under the terms of the GNU General Public License v2

# @ECLASS: elf-qa.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Binary QA scanner and assert helpers for installed ELFs
# @DESCRIPTION:
# Scans installed ELF files, writes a report, and enforces policy

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_ELF_QA_ECLASS} ]] ; then
_ELF_QA_ECLASS=1

inherit toolchain-funcs

: "${ELFQA_MODE:=strict}"
: "${ELFQA_ALLOW:=}"
: "${ELFQA_ALLOW_RPATH:=0}"
: "${ELFQA_FORBID_NEEDED:=}"
: "${ELFQA_EXPECT_OSABI:=}"
: "${ELFQA_EXPECT_INTERP:=}"
: "${ELFQA_REQUIRE_BUILD_ID:=0}"
: "${ELFQA_REQUIRE_GNU_STACK:=1}"
: "${ELFQA_CHECK_UNDEFINED:=0}"
: "${ELFQA_REPORT_HARDENING:=1}"
: "${ELFQA_REQUIRE_PIE:=0}"
: "${ELFQA_REQUIRE_RELRO:=0}"
: "${ELFQA_REQUIRE_NOW:=0}"
: "${ELFQA_REQUIRE_NX:=0}"

_ELFQA_FAILURES=0
_ELFQA_SCANNED=0

_elfqa-report-file() {
	if [[ -n ${ELFQA_REPORT_FILE} ]]; then
		echo "${ELFQA_REPORT_FILE}"
		return
	fi

	echo "${T:-/tmp}/elfqa-report.log"
}

_elfqa-write-report() {
	local level=$1
	local rule=$2
	local rel=$3
	local detail=$4
	printf '%s|%s|%s|%s\n' "${level}" "${rule}" "${rel}" "${detail}" >> "$(_elfqa-report-file)"
}

_elfqa-rule-allowed() {
	local rule=$1
	local rel=$2
	local token rule_part re

	for token in ${ELFQA_ALLOW}; do
		if [[ ${token} == *:* ]]; then
			rule_part=${token%%:*}
			re=${token#*:}
			[[ ${rule} == "${rule_part}" && ${rel} =~ ${re} ]] && return 0
		else
			[[ ${rel} =~ ${token} ]] && return 0
		fi
	done

	return 1
}

_elfqa-violation() {
	local rule=$1
	local rel=$2
	local detail=$3

	if _elfqa-rule-allowed "${rule}" "${rel}"; then
		einfo "elfqa: allowlisted ${rule} for ${rel}"
		_elfqa-write-report allow "${rule}" "${rel}" "${detail}"
		return
	fi

	eerror "elfqa: ${rule} in ${rel}: ${detail}"
	_elfqa-write-report error "${rule}" "${rel}" "${detail}"
	(( _ELFQA_FAILURES += 1 ))
}

_elfqa-note() {
	local rule=$1
	local rel=$2
	local detail=$3
	_elfqa-write-report info "${rule}" "${rel}" "${detail}"
}

_elfqa-default-interp() {
	case ${CHOST} in
		x86_64*) echo '^/lib64/ld-linux-x86-64\.so\.2$' ;;
		i?86*) echo '^/lib/ld-linux\.so\.2$' ;;
		aarch64*) echo '^/lib/ld-linux-aarch64\.so\.1$' ;;
		riscv64*) echo '^/lib/ld-linux-riscv64-lp64d\.so\.1$' ;;
		*) echo '' ;;
	esac
}

_elfqa-find-files() {
	local input
	local -a files=()
	local -a found=()

	if [[ ${#} -eq 0 ]]; then
		set -- "${ED}"
	fi

	for input in "$@" ; do
		[[ -e ${input} ]] || die "elfqa: missing path ${input}"
	done

	for input in "$@" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} ]]; then
			files+=( "${input}" )
		fi
	done

	echo "${files[@]}"
}

_elfqa-is-elf() {
	local file=$1
	local readelf_cmd
	readelf_cmd=$(tc-getREADELF)
	"${readelf_cmd}" -h "${file}" >/dev/null 2>&1
}

_elfqa-type() {
	local file=$1
	local readelf_cmd
	readelf_cmd=$(tc-getREADELF)
	"${readelf_cmd}" -h "${file}" 2>/dev/null | awk '/Type:/ { print $2; exit }'
}

_elfqa-interp() {
	local file=$1
	local readelf_cmd
	readelf_cmd=$(tc-getREADELF)
	"${readelf_cmd}" -W -l "${file}" 2>/dev/null | sed -n 's#.*Requesting program interpreter: \(.*\)]#\1#p' | head -n1
}

_elfqa-dyn() {
	local file=$1
	local readelf_cmd
	readelf_cmd=$(tc-getREADELF)
	"${readelf_cmd}" -d "${file}" 2>/dev/null || true
}

_elfqa-rpath() {
	local file=$1
	local dyn out
	dyn=$(_elfqa-dyn "${file}")
	out=$(echo "${dyn}" | sed -n 's/.*(RPATH).*\[\(.*\)\].*/\1/p' | head -n1)
	[[ -n ${out} ]] || out=$(echo "${dyn}" | sed -n 's/.*(RUNPATH).*\[\(.*\)\].*/\1/p' | head -n1)
	echo "${out}"
}

_elfqa-check-textrel() {
	local file=$1
	local rel=$2
	_elfqa-dyn "${file}" | grep -q '(TEXTREL)' && _elfqa-violation textrel "${rel}" 'TEXTREL dynamic tag present'
}

_elfqa-check-stack() {
	local file=$1
	local rel=$2
	local readelf_cmd stack_line
	readelf_cmd=$(tc-getREADELF)
	stack_line=$("${readelf_cmd}" -W -l "${file}" 2>/dev/null | awk '/GNU_STACK/ { print; exit }')

	if [[ -z ${stack_line} ]]; then
		if [[ ${ELFQA_REQUIRE_GNU_STACK} == 1 ]]; then
			_elfqa-violation gnu_stack_missing "${rel}" 'GNU_STACK program header missing'
		fi
		return
	fi

	if [[ ${stack_line} == *RWE* ]] || [[ ${stack_line} == *" E "* ]]; then
		_elfqa-violation execstack "${rel}" 'GNU_STACK is executable'
	fi
}

_elfqa-check-interpreter() {
	local file=$1
	local rel=$2
	local interp expected

	interp=$(_elfqa-interp "${file}")
	[[ -n ${interp} ]] || return

	expected=${ELFQA_EXPECT_INTERP}
	[[ -n ${expected} ]] || expected=$(_elfqa-default-interp)
	[[ -z ${expected} ]] && return

	if [[ ! ${interp} =~ ${expected} ]]; then
		_elfqa-violation interp "${rel}" "unexpected PT_INTERP ${interp}"
	fi
}

_elfqa-check-rpath() {
	local file=$1
	local rel=$2
	local rp

	rp=$(_elfqa-rpath "${file}")
	[[ -n ${rp} ]] || return

	if [[ ${ELFQA_ALLOW_RPATH} == 1 ]]; then
		_elfqa-note rpath "${rel}" "rpath present ${rp}"
		return
	fi

	_elfqa-violation rpath "${rel}" "RPATH or RUNPATH present: ${rp}"
}

_elfqa-check-needed() {
	local file=$1
	local rel=$2
	local dyn needed re

	dyn=$(_elfqa-dyn "${file}")
	[[ -n ${dyn} ]] || return

	while IFS= read -r needed; do
		for re in ${ELFQA_FORBID_NEEDED}; do
			if [[ ${needed} =~ ${re} ]]; then
				_elfqa-violation needed "${rel}" "forbidden NEEDED ${needed}"
			fi
		done
	done < <(echo "${dyn}" | sed -n 's/.*(NEEDED).*\[\(.*\)\].*/\1/p')
}

_elfqa-check-osabi() {
	local file=$1
	local rel=$2
	local readelf_cmd osabi

	[[ -n ${ELFQA_EXPECT_OSABI} ]] || return
	readelf_cmd=$(tc-getREADELF)
	osabi=$("${readelf_cmd}" -h "${file}" 2>/dev/null | awk -F: '/OS\/ABI/ { gsub(/^[[:space:]]+/, "", $2); print $2; exit }')
	[[ -n ${osabi} ]] || return

	if [[ ${osabi} != "${ELFQA_EXPECT_OSABI}" ]]; then
		_elfqa-violation osabi "${rel}" "expected ${ELFQA_EXPECT_OSABI}, got ${osabi}"
	fi
}

_elfqa-check-buildid() {
	local file=$1
	local rel=$2
	local readelf_cmd

	[[ ${ELFQA_REQUIRE_BUILD_ID} == 1 ]] || return
	readelf_cmd=$(tc-getREADELF)
	if ! "${readelf_cmd}" -n "${file}" 2>/dev/null | grep -q 'Build ID'; then
		_elfqa-violation build_id "${rel}" 'missing GNU build-id note'
	fi
}

_elfqa-check-undefined() {
	local file=$1
	local rel=$2
	local etype

	[[ ${ELFQA_CHECK_UNDEFINED} == 1 ]] || return
	etype=$(_elfqa-type "${file}")
	[[ ${etype} == EXEC ]] || return

	local readelf_cmd first_undef
	readelf_cmd=$(tc-getREADELF)
	first_undef=$("${readelf_cmd}" -W -s "${file}" 2>/dev/null | awk '$5 == "GLOBAL" && $7 == "UND" { print $8; exit }')
	if [[ -n ${first_undef} ]]; then
		_elfqa-violation undefined "${rel}" "unexpected undefined symbol ${first_undef}"
	fi
}

_elfqa-hardening() {
	local file=$1
	local rel=$2
	local etype interp pie relro now nx stack_line ssp fortify
	local readelf_cmd dyn

	readelf_cmd=$(tc-getREADELF)
	etype=$(_elfqa-type "${file}")
	interp=$(_elfqa-interp "${file}")
	dyn=$(_elfqa-dyn "${file}")

	pie=0
	relro=0
	now=0
	nx=0
	ssp=0
	fortify=0

	[[ ${etype} == DYN && -n ${interp} ]] && pie=1
	"${readelf_cmd}" -W -l "${file}" 2>/dev/null | grep -q 'GNU_RELRO' && relro=1
	echo "${dyn}" | grep -Eq 'BIND_NOW|FLAGS_1.*NOW' && now=1

	stack_line=$("${readelf_cmd}" -W -l "${file}" 2>/dev/null | awk '/GNU_STACK/ { print; exit }')
	if [[ -n ${stack_line} && ${stack_line} != *RWE* && ${stack_line} != *" E "* ]]; then
		nx=1
	fi

	"${readelf_cmd}" -W -s "${file}" 2>/dev/null | grep -q '__stack_chk_fail' && ssp=1
	"${readelf_cmd}" -W -s "${file}" 2>/dev/null | grep -Eq '__[[:alnum:]_]+_chk(@|$)' && fortify=1

	[[ ${ELFQA_REQUIRE_PIE} == 1 && ${pie} == 0 ]] && _elfqa-violation pie "${rel}" 'PIE required but missing'
	[[ ${ELFQA_REQUIRE_RELRO} == 1 && ${relro} == 0 ]] && _elfqa-violation relro "${rel}" 'RELRO required but missing'
	[[ ${ELFQA_REQUIRE_NOW} == 1 && ${now} == 0 ]] && _elfqa-violation now "${rel}" 'BIND_NOW required but missing'
	[[ ${ELFQA_REQUIRE_NX} == 1 && ${nx} == 0 ]] && _elfqa-violation nx "${rel}" 'NX stack required but missing'

	if [[ ${ELFQA_REPORT_HARDENING} == 1 ]]; then
		_elfqa-note hardening "${rel}" "pie=${pie} relro=${relro} now=${now} nx=${nx} ssp=${ssp} fortify=${fortify}"
	fi
}

# @FUNCTION: elfqa-scan
# @USAGE: [path] [more]
# @DESCRIPTION:
# Scan installed ELF files and write a structured report
elfqa-scan() {
	case ${ELFQA_MODE} in
		strict|report) ;;
		*) die "elfqa-scan: invalid ELFQA_MODE=${ELFQA_MODE}" ;;
	esac

	: > "$(_elfqa-report-file)" || die "elfqa: unable to create report"

	_ELFQA_FAILURES=0
	_ELFQA_SCANNED=0

	local -a files=( $(_elfqa-find-files "$@") )
	[[ ${#files[@]} -gt 0 ]] || return 0

	local file rel
	for file in "${files[@]}" ; do
		_elfqa-is-elf "${file}" || continue
		rel=${file#${ED}}
		(( _ELFQA_SCANNED += 1 ))

		_elfqa-check-textrel "${file}" "${rel}"
		_elfqa-check-stack "${file}" "${rel}"
		_elfqa-check-interpreter "${file}" "${rel}"
		_elfqa-check-rpath "${file}" "${rel}"
		_elfqa-check-needed "${file}" "${rel}"
		_elfqa-check-osabi "${file}" "${rel}"
		_elfqa-check-buildid "${file}" "${rel}"
		_elfqa-check-undefined "${file}" "${rel}"
		_elfqa-hardening "${file}" "${rel}"
	done

	einfo "elfqa: scanned ${_ELFQA_SCANNED} ELF file(s), failures ${_ELFQA_FAILURES}"
	[[ ${_ELFQA_FAILURES} -eq 0 ]]
}

# @FUNCTION: elfqa-assert
# @USAGE: [path] [more]
# @DESCRIPTION:
# Run scan and fail closed under strict mode
elfqa-assert() {
	if ! elfqa-scan "$@"; then
		if [[ ${ELFQA_MODE} == strict ]]; then
			die "elfqa-assert: policy violations detected"
		fi
		ewarn "elfqa-assert: policy violations detected"
	fi
}

fi

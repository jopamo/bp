# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-elf.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal ELF validation helpers for qa-policy

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_QA_ELF_ECLASS} ]] ; then
_QA_ELF_ECLASS=1

inherit qa-report elf-qa

_qa-elf-path-allowed() {
	local rel=$1
	local list=$2
	local re

	for re in ${list}; do
		[[ ${rel} =~ ${re} ]] && return 0
	done
	return 1
}

qa-elf-list() {
	printf '%s\n' "${QA_DISCOVER_ELF_FILES[@]}"
}

qa-elf-check-interpreter() {
	local file=$1
	local rel=$2
	local etype interp expected

	etype=$(_elfqa-type "${file}")
	interp=$(_elfqa-interp "${file}")

	if [[ ${etype} == EXEC || ( ${etype} == DYN && -n ${interp} ) ]]; then
		if [[ -z ${interp} ]]; then
			_qa-elf-path-allowed "${rel}" "${QA_POLICY_ELF_ALLOW_INTERP}" || \
				_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" missing-interpreter "${rel}" "missing PT_INTERP entry"
			return 0
		fi

		expected=$(_elfqa-default-interp)
		if [[ -n ${expected} && ! ${interp} =~ ${expected} ]] && ! _qa-elf-path-allowed "${rel}" "${QA_POLICY_ELF_ALLOW_INTERP}"; then
			_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" unexpected-interpreter "${rel}" "unexpected interpreter ${interp}"
		fi
	fi
}

qa-elf-check-soname() {
	local file=$1
	local rel=$2
	local etype interp soname dyn

	etype=$(_elfqa-type "${file}")
	interp=$(_elfqa-interp "${file}")
	[[ ${etype} == DYN && -z ${interp} ]] || return 0

	case ${rel} in
		*.so|*.so.*) ;;
		*) return 0 ;;
	esac

	dyn=$(_elfqa-dyn "${file}")
	soname=$(sed -n 's/.*(SONAME).*\[\(.*\)\].*/\1/p' <<< "${dyn}" | head -n1)
	[[ -n ${soname} ]] && return 0

	_qa-elf-path-allowed "${rel}" "${QA_POLICY_ELF_ALLOW_MISSING_SONAME}" || \
		_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" missing-soname "${rel}" "shared object is missing DT_SONAME"
}

qa-elf-check-textrel() {
	local file=$1
	local rel=$2

	if _elfqa-dyn "${file}" | grep -q '(TEXTREL)' && ! _qa-elf-path-allowed "${rel}" "${QA_POLICY_ELF_ALLOW_TEXTREL}"; then
		_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" textrel "${rel}" "TEXTREL dynamic tag present"
	fi
}

qa-elf-check-execstack() {
	local file=$1
	local rel=$2
	local readelf_cmd stack_line

	readelf_cmd=$(tc-getREADELF)
	stack_line=$("${readelf_cmd}" -W -l "${file}" 2>/dev/null | awk '/GNU_STACK/ { print; exit }')

	if [[ -z ${stack_line} ]]; then
		[[ ${QA_POLICY_ELF_REQUIRE_GNU_STACK} == 1 ]] && \
			_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" missing-gnu-stack "${rel}" "GNU_STACK program header missing"
		return 0
	fi

	if [[ ${stack_line} == *RWE* || ${stack_line} == *" E "* ]] && ! _qa-elf-path-allowed "${rel}" "${QA_POLICY_ELF_ALLOW_EXECSTACK}"; then
		_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" execstack "${rel}" "GNU_STACK is executable"
	fi
}

qa-elf-check-rpath() {
	local file=$1
	local rel=$2
	local current

	[[ ${QA_POLICY_RPATH_MODE} == off ]] || return 0
	current=$(_elfqa-rpath "${file}")
	[[ -z ${current} ]] || _qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" rpath "${rel}" "RPATH or RUNPATH present: ${current}"
}

qa-elf-check-needed() {
	local file=$1
	local rel=$2
	local needed

	while IFS= read -r needed; do
		[[ -n ${needed} ]] || continue
		if [[ ${needed} == /* ]] || grep -Eq '/var/tmp/|/tmp/portage/' <<< "${needed}"; then
			_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" bad-needed "${rel}" "unexpected DT_NEEDED entry ${needed}"
			return 0
		fi
	done < <(sed -n 's/.*(NEEDED).*\[\(.*\)\].*/\1/p' <<< "$(_elfqa-dyn "${file}")")
}

qa-elf-check-relro() {
	local file=$1
	local rel=$2
	local readelf_cmd

	[[ ${QA_POLICY_ELF_REQUIRE_RELRO} == 1 ]] || return 0
	readelf_cmd=$(tc-getREADELF)
	"${readelf_cmd}" -W -l "${file}" 2>/dev/null | grep -q 'GNU_RELRO' || \
		_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" relro "${rel}" "RELRO required but missing"
}

qa-elf-check-now() {
	local file=$1
	local rel=$2

	[[ ${QA_POLICY_ELF_REQUIRE_NOW} == 1 ]] || return 0
	_elfqa-dyn "${file}" | grep -Eq 'BIND_NOW|FLAGS_1.*NOW' || \
		_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" now "${rel}" "BIND_NOW required but missing"
}

qa-elf-check-pie() {
	local file=$1
	local rel=$2
	local etype interp

	[[ ${QA_POLICY_ELF_REQUIRE_PIE} == 1 ]] || return 0
	etype=$(_elfqa-type "${file}")
	interp=$(_elfqa-interp "${file}")
	[[ ${etype} == DYN && -n ${interp} ]] || \
		_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" pie "${rel}" "PIE required but missing"
}

qa-elf-assert() {
	qa-report-domain-begin elf

	local file rel
	local -i scanned=0

	for file in "${QA_DISCOVER_ELF_FILES[@]}"; do
		(( scanned += 1 ))
		rel=$(_qa-policy-relpath "${file}")

		qa-elf-check-interpreter "${file}" "${rel}"
		qa-elf-check-soname "${file}" "${rel}"
		qa-elf-check-textrel "${file}" "${rel}"
		qa-elf-check-execstack "${file}" "${rel}"
		qa-elf-check-rpath "${file}" "${rel}"
		qa-elf-check-needed "${file}" "${rel}"
		qa-elf-check-relro "${file}" "${rel}"
		qa-elf-check-now "${file}" "${rel}"
		qa-elf-check-pie "${file}" "${rel}"
	done

	qa-report-domain-stat elf scanned "${scanned}"
}

fi

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

if [[ -z ${_QA_ELF_ECLASS:-} ]] ; then
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
	local etype interp soname dyn base

	etype=$(_elfqa-type "${file}")
	interp=$(_elfqa-interp "${file}")
	[[ ${etype} == DYN && -z ${interp} ]] || return 0

	case ${rel} in
		*.so|*.so.*) ;;
		*) return 0 ;;
	esac

	dyn=$(_elfqa-dyn "${file}")
	soname=$(sed -n 's/.*(SONAME).*\[\(.*\)\].*/\1/p' <<< "${dyn}" | head -n1)
	if [[ -n ${soname} ]]; then
		case ${rel} in
			*.so.*)
				base=${rel##*/}
				if [[ ${base} != "${soname}" && ${base} != "${soname}".* ]]; then
					_qa-report-record-mode elf "${QA_POLICY_ELF_MODE}" soname-mismatch "${rel}" \
						"DT_SONAME (${soname}) does not match installed filename (${base})"
				fi
				;;
		esac
		return 0
	fi

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

qa-elf-check-hardening-presence() {
	local file=$1
	local rel=$2
	local mode=${QA_POLICY_ELF_HARDENING_MODE}
	local dyn stack_line readelf_cmd
	local -i ssp_present=0 fortify_present=0 nx_present=0

	[[ ${mode} != off ]] || return 0

	dyn=$(_elfqa-dyn "${file}")
	grep -Eq '\[(__stack_chk_fail|__stack_chk_guard)(@|]|$)' <<< "${dyn}" && ssp_present=1
	grep -Eq '\[__[^]]+_chk(@|]|$)' <<< "${dyn}" && fortify_present=1

	readelf_cmd=$(tc-getREADELF)
	stack_line=$("${readelf_cmd}" -W -l "${file}" 2>/dev/null | awk '/GNU_STACK/ { print; exit }')
	if [[ -n ${stack_line} && ${stack_line} != *RWE* && ${stack_line} != *" E "* ]]; then
		nx_present=1
	fi

	if (( ssp_present == 0 )); then
		_qa-report-record-mode elf "${mode}" ssp-missing "${rel}" "no stack protector runtime symbol reference found"
	fi
	if (( fortify_present == 0 )); then
		_qa-report-record-mode elf "${mode}" fortify-missing "${rel}" "no fortified *_chk symbol reference found"
	fi
	if (( nx_present == 0 )); then
		_qa-report-record-mode elf "${mode}" nx-missing "${rel}" "GNU_STACK indicates executable stack or missing NX marker"
	fi
}

_qa-elf-parse-needed() {
	sed -n 's/.*(NEEDED).*\[\(.*\)\].*/\1/p' <<< "$(_elfqa-dyn "$1")"
}

_qa-elf-resolve-needed() {
	local needed=$1
	local root dir
	local -a roots=()

	if [[ -n ${ED-} ]]; then
		roots+=( "${ED%/}" )
	fi

	if declare -p QA_DISCOVER_ROOTS >/dev/null 2>&1; then
		roots+=( "${QA_DISCOVER_ROOTS[@]}" )
	fi

	for root in "${roots[@]}"; do
		for dir in /usr/lib /usr/lib64 /lib /lib64; do
			if [[ -f ${root%/}${dir}/${needed} ]]; then
				printf '%s\n' "${root%/}${dir}/${needed}"
				return 0
			fi
		done
	done

	for dir in /usr/lib /usr/lib64 /lib /lib64; do
		if [[ -f ${dir}/${needed} ]]; then
			printf '%s\n' "${dir}/${needed}"
			return 0
		fi
	done

	return 1
}

qa-elf-check-unused-needed() {
	local file=$1
	local rel=$2
	local readelf_cmd mode needed resolved sym
	local -a undefined=()
	local -A unresolved=()
	local -A exported=()
	local -i hit

	[[ ${QA_POLICY_ELF_CHECK_UNUSED_DT_NEEDED} == 1 ]] || return 0

	readelf_cmd=$(tc-getREADELF)
	mode=${QA_POLICY_ELF_HARDENING_MODE}
	[[ ${mode} != off ]] || mode=report

	while IFS= read -r sym; do
		[[ -n ${sym} ]] || continue
		sym=${sym%%@*}
		unresolved[${sym}]=1
		undefined+=( "${sym}" )
	done < <("${readelf_cmd}" -W -Ws "${file}" 2>/dev/null | awk '$7 == "UND" { print $8 }' | sed '/^$/d' | sort -u)

	[[ ${#undefined[@]} -gt 0 ]] || return 0

	while IFS= read -r needed; do
		[[ -n ${needed} ]] || continue
		case ${needed} in
			libc.so.*|ld-linux*.so.*|ld-musl-*.so.*) continue ;;
		esac

		resolved=$(_qa-elf-resolve-needed "${needed}") || continue
		exported=()
		while IFS= read -r sym; do
			[[ -n ${sym} ]] || continue
			sym=${sym%%@*}
			exported[${sym}]=1
		done < <("${readelf_cmd}" -W -Ws "${resolved}" 2>/dev/null | awk '$7 != "UND" { print $8 }' | sed '/^$/d')

		hit=0
		for sym in "${undefined[@]}"; do
			if [[ -n ${exported[${sym}]:-} ]]; then
				hit=1
				break
			fi
		done

		if (( hit == 0 )); then
			_qa-report-record-mode elf "${mode}" unused-dt-needed-candidate "${rel}" \
				"no direct unresolved symbols matched ${needed} (candidate overlinking)"
		fi
	done < <(_qa-elf-parse-needed "${file}")
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
		qa-elf-check-hardening-presence "${file}" "${rel}"
		qa-elf-check-unused-needed "${file}" "${rel}"
	done

	qa-report-domain-stat elf scanned "${scanned}"
}

fi

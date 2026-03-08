# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-linker.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal linker policy setup and assertion helpers for qa-policy

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_QA_LINKER_ECLASS} ]] ; then
_QA_LINKER_ECLASS=1

inherit qa-report linker-policy

_QA_LINKER_CONFIGURED=0
_QA_LINKER_LAST_EXPECTED=

_qa-linker-path-allowed() {
	local rel=$1
	local re

	for re in ${QA_POLICY_LINKER_ALLOW}; do
		[[ ${rel} =~ ${re} ]] && return 0
	done
	return 1
}

qa-linker-detect-expected() {
	case ${QA_POLICY_LINKER_EXPECTED} in
		''|auto)
			if [[ -n ${LP_LINKER} ]]; then
				printf '%s\n' "${LP_LINKER}"
				return 0
			fi
			case ${LDFLAGS} in
				*-fuse-ld=bfd*) printf '%s\n' bfd ;;
				*-fuse-ld=lld*) printf '%s\n' lld ;;
				*-fuse-ld=mold*) printf '%s\n' mold ;;
				*) printf '\n' ;;
			esac
			;;
		bfd|lld|mold)
			printf '%s\n' "${QA_POLICY_LINKER_EXPECTED}"
			;;
		*)
			die "qa-linker: invalid QA_POLICY_LINKER_EXPECTED=${QA_POLICY_LINKER_EXPECTED}"
			;;
	esac
}

qa-linker-configure() {
	[[ ${QA_POLICY_LINKER_MODE} != off ]] || return 0

	local expected
	expected=$(qa-linker-detect-expected)

	if [[ ${_QA_LINKER_CONFIGURED} == 1 && ${_QA_LINKER_LAST_EXPECTED} == "${expected}" ]]; then
		return 0
	fi

	LP_MODE=compat
	LP_PREFER=${expected}
	lp-setup

	_QA_LINKER_CONFIGURED=1
	_QA_LINKER_LAST_EXPECTED=${expected}
}

qa-linker-scan-elf() {
	_lp-detect-linker "$1"
}

qa-linker-assert() {
	qa-report-domain-begin linker

	local expected detected rel file
	local -i scanned=0 mismatches=0 unknown=0
	local mode=${QA_POLICY_LINKER_MODE}

	expected=$(qa-linker-detect-expected)

	for file in "${QA_DISCOVER_ELF_FILES[@]}"; do
		_lp-is-dynamic-target "${file}" || continue
		(( scanned += 1 ))

		rel=$(_qa-policy-relpath "${file}")
		detected=$(qa-linker-scan-elf "${file}")

		if [[ ${detected} == unknown ]]; then
			(( unknown += 1 ))
			if [[ -n ${expected} ]] && ! _qa-linker-path-allowed "${rel}"; then
				_qa-report-record-mode linker "${mode}" unknown-linker "${rel}" "expected ${expected}, linker signature not detected"
			fi
			continue
		fi

		if [[ -n ${expected} && ${detected} != "${expected}" ]] && ! _qa-linker-path-allowed "${rel}"; then
			(( mismatches += 1 ))
			_qa-report-record-mode linker "${mode}" unexpected-linker "${rel}" "expected ${expected}, found ${detected}"
		fi
	done

	qa-report-domain-stat linker scanned "${scanned}"
	qa-report-domain-stat linker mismatches "${mismatches}"
	qa-report-domain-stat linker unknown "${unknown}"
}

fi

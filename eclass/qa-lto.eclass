# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-lto.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal LTO setup and sanitize helpers for qa-policy


if [[ -z ${_QA_LTO_ECLASS:-} ]] ; then
_QA_LTO_ECLASS=1

inherit qa-report lto-policy

_QA_LTO_LAST_FLAVOR=

qa-lto-resolve-flavor() {
	case ${QA_POLICY_LTO_FLAVOR-auto} in
		auto)
			if in_iuse static-libs && use static-libs; then
				printf '%s\n' fat+strip
			else
				printf '%s\n' none
			fi
			;;
		none|full|thin|thin+cache|fat+strip)
			printf '%s\n' "${QA_POLICY_LTO_FLAVOR}"
			;;
		*)
			die "qa-lto: invalid QA_POLICY_LTO_FLAVOR=${QA_POLICY_LTO_FLAVOR-}"
			;;
	esac
}

qa-lto-configure() {
	[[ ${QA_POLICY_LTO_MODE} != off ]] || return 0

	local flavor
	flavor=$(qa-lto-resolve-flavor)
	[[ ${_QA_LTO_LAST_FLAVOR} == "${flavor}" ]] && return 0

	LTO_POLICY_MODE=${flavor}
	lto-setup
	_QA_LTO_LAST_FLAVOR=${flavor}
}

qa-lto-strip-archive-ir() {
	_lto-policy-strip-bytecode "$@"
}

qa-lto-sanitize() {
	qa-report-domain-begin lto

	local -a archives=( "${QA_DISCOVER_ARCHIVES[@]}" )
	local archive ranlib_cmd
	local -i archives_scanned=${#archives[@]} archives_rewritten=0 ir_before=0 ir_after=0

	if [[ ${#archives[@]} -gt 0 ]] && [[ ${QA_POLICY_LTO_STRIP_ARCHIVE_IR} == 1 ]]; then
		for archive in "${archives[@]}"; do
			_lto-policy-has-ir "${archive}" && (( ir_before += 1 ))
		done

		if [[ ${ir_before} -gt 0 ]]; then
			qa-lto-strip-archive-ir "${archives[@]}"
			archives_rewritten=${ir_before}
		fi
	fi

	ranlib_cmd=$(tc-getRANLIB)
	for archive in "${archives[@]}"; do
		"${ranlib_cmd}" "${archive}" || die "qa-lto: ranlib failed for ${archive}"
		_lto-policy-has-ir "${archive}" && (( ir_after += 1 ))
	done

	qa-report-domain-stat lto archives_scanned "${archives_scanned}"
	qa-report-domain-stat lto archives_rewritten "${archives_rewritten}"
	qa-report-domain-stat lto ir_payloads_removed "$(( ir_before - ir_after ))"
}

fi

# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-perms.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal permission sanitize and assertion helpers for qa-policy


if [[ -z ${_QA_PERMS_ECLASS:-} ]] ; then
_QA_PERMS_ECLASS=1

inherit qa-report

_qa-perms-mode-bits() {
	local file=$1
	local mode

	mode=$(stat -c '%a' "${file}") || die "qa-perms: stat failed for ${file}"
	printf '%s\n' "$(( 8#${mode} ))"
}

_qa-perms-format-mode() {
	printf '%04o\n' "${1}"
}

_qa-perms-suid-sgid-allowed() {
	local rel=$1
	local re

	for re in ${QA_POLICY_PERMS_SUID_SGID_ALLOW}; do
		[[ ${rel} =~ ${re} ]] && return 0
	done
	return 1
}

_qa-perms-is-common-nonexec-path() {
	local rel=${1,,}
	local base=${rel##*/}

	case ${rel} in
		*.txt|*.text|*.md|*.markdown|*.rst|*.adoc|*.json|*.yaml|*.yml|*.toml|*.ini|*.cfg|*.conf|*.xml|*.csv|*.tsv|*.sql|*.po|*.pot|*.desktop|*.service|*.socket|*.target|*.timer|*.path|*.mount|*.automount|*.html|*.htm|*.css|*.png|*.jpg|*.jpeg|*.gif|*.svg|*.ico|*.pdf|*.pc|*.la|*.o|*.a|*.h|*.hh|*.hpp|*.c|*.cc|*.cpp|*.cxx|*.go|*.rs|*.gz|*.xz|*.bz2|*.zst|*.lz4|*.zip|*.tar|*.tgz|*.tbz2|*.txz)
			return 0
			;;
	esac

	case ${rel} in
		/usr/share/doc/*|/usr/share/info/*|/usr/share/man/*|/usr/share/licenses/*|/usr/share/license/*|/usr/share/gtk-doc/*)
			case ${base} in
				readme|news|copying|license|authors|changelog|install|thanks|todo)
					return 0
					;;
			esac
			;;
	esac

	return 1
}

_qa-perms-apply-mode() {
	local file=$1
	local mode=$2

	chmod "$(_qa-perms-format-mode "${mode}")" "${file}" || die "qa-perms: chmod failed for ${file}"
}

qa-perms-list() {
	printf '%s\n' "${QA_DISCOVER_ALL_FILES[@]}"
}

qa-perms-sanitize() {
	qa-report-domain-begin perms

	local file rel mode_bits new_mode
	local -i strip_suid_sgid strip_world_writable strip_unexpected_exec
	local -i files_scanned=0 files_modified=0 suid_sgid_stripped=0
	local -i world_writable_stripped=0 unexpected_exec_stripped=0

	for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
		(( files_scanned += 1 ))
		mode_bits=$(_qa-perms-mode-bits "${file}")
		new_mode=${mode_bits}
		rel=$(_qa-policy-relpath "${file}")
		strip_suid_sgid=0
		strip_world_writable=0
		strip_unexpected_exec=0

		if (( (mode_bits & 06000) != 0 )) && ! _qa-perms-suid-sgid-allowed "${rel}"; then
			(( new_mode &= ~06000 ))
			strip_suid_sgid=1
		fi

		if (( (mode_bits & 0002) != 0 )); then
			(( new_mode &= ~0002 ))
			strip_world_writable=1
		fi

		if (( (mode_bits & 0111) != 0 )) && _qa-perms-is-common-nonexec-path "${rel}"; then
			(( new_mode &= ~0111 ))
			strip_unexpected_exec=1
		fi

		(( new_mode != mode_bits )) || continue
		[[ ${QA_POLICY_PERMS_SANITIZE} == 1 ]] || continue

		_qa-perms-apply-mode "${file}" "${new_mode}"
		(( files_modified += 1 ))

		if (( strip_suid_sgid == 1 )); then
			(( suid_sgid_stripped += 1 ))
			qa-report-note perms stripped-suid-sgid "${rel}" "removed setuid/setgid bits ($(_qa-perms-format-mode "${mode_bits}") -> $(_qa-perms-format-mode "${new_mode}"))"
		fi

		if (( strip_world_writable == 1 )); then
			(( world_writable_stripped += 1 ))
			qa-report-note perms stripped-world-writable "${rel}" "removed world-writable bit ($(_qa-perms-format-mode "${mode_bits}") -> $(_qa-perms-format-mode "${new_mode}"))"
		fi

		if (( strip_unexpected_exec == 1 )); then
			(( unexpected_exec_stripped += 1 ))
			qa-report-note perms stripped-unexpected-exec-bit "${rel}" "removed executable bits from non-executable type ($(_qa-perms-format-mode "${mode_bits}") -> $(_qa-perms-format-mode "${new_mode}"))"
		fi
	done

	qa-report-domain-stat perms files_scanned "${files_scanned}"
	qa-report-domain-stat perms files_modified "${files_modified}"
	qa-report-domain-stat perms suid_sgid_stripped "${suid_sgid_stripped}"
	qa-report-domain-stat perms world_writable_stripped "${world_writable_stripped}"
	qa-report-domain-stat perms unexpected_exec_stripped "${unexpected_exec_stripped}"
}

qa-perms-assert() {
	qa-report-domain-begin perms

	local file rel mode_bits
	local -i files_scanned=0

	for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
		(( files_scanned += 1 ))
		mode_bits=$(_qa-perms-mode-bits "${file}")
		rel=$(_qa-policy-relpath "${file}")

		if (( (mode_bits & 06000) != 0 )) && ! _qa-perms-suid-sgid-allowed "${rel}"; then
			_qa-report-record-mode perms "${QA_POLICY_PERMS_MODE}" suid-sgid "${rel}" "setuid/setgid bit present (mode $(_qa-perms-format-mode "${mode_bits}"))"
		fi

		if [[ ${QA_POLICY_PERMS_CHECK_WORLD_WRITABLE} == 1 ]] && (( (mode_bits & 0002) != 0 )); then
			_qa-report-record-mode perms "${QA_POLICY_PERMS_MODE}" world-writable "${rel}" "world-writable bit present (mode $(_qa-perms-format-mode "${mode_bits}"))"
		fi

		if (( (mode_bits & 0111) != 0 )) && _qa-perms-is-common-nonexec-path "${rel}"; then
			_qa-report-record-mode perms "${QA_POLICY_PERMS_MODE}" unexpected-exec-bit "${rel}" "executable bit present for non-executable file type (mode $(_qa-perms-format-mode "${mode_bits}"))"
		fi
	done

	qa-report-domain-stat perms files_scanned "${files_scanned}"
}

fi

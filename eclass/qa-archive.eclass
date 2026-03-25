# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-archive.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal archive sanitize and assertion helpers for qa-policy


if [[ -z ${_QA_ARCHIVE_ECLASS:-} ]] ; then
_QA_ARCHIVE_ECLASS=1

inherit qa-report binutils-sanitizer lto-policy

qa-archive-list() {
	printf '%s\n' "${QA_DISCOVER_ARCHIVES[@]}"
}

qa-archive-fix-index() {
	local archive=$1
	local ar_cmd ranlib_cmd

	ar_cmd=$(tc-getAR)
	ranlib_cmd=$(tc-getRANLIB)

	"${ar_cmd}" s "${archive}" >/dev/null 2>&1 || true
	"${ranlib_cmd}" "${archive}" || die "qa-archive: ranlib failed for ${archive}"
}

qa-archive-check-index() {
	_bu-has-index "$1"
}

qa-archive-check-thin() {
	_bu-is-thin "$1"
}

qa-archive-check-ldscript() {
	local script=$1
	local rel=$2
	local dep

	if ! _bu-ldscript-has-header "${script}"; then
		_qa-report-record-mode archive "${QA_POLICY_ARCHIVE_MODE}" malformed-ldscript "${rel}" "missing GNU ld script header"
	fi

	if [[ ${rel} == */libbfd.so ]]; then
		local -a required=( -liberty -lsframe -lz -lzstd -lstdc++ -ldl )
		for dep in "${required[@]}"; do
			if ! _bu-ldscript-has-token "${script}" "${dep}"; then
				_qa-report-record-mode archive "${QA_POLICY_ARCHIVE_MODE}" malformed-ldscript "${rel}" "missing required token ${dep}"
			fi
		done
	fi
}

qa-archive-list-duplicate-members() {
	local archive=$1
	local ar_cmd

	ar_cmd=$(tc-getAR)
	"${ar_cmd}" t "${archive}" | sed '/^$/d' | sort | uniq -d
}

qa-archive-duplicate-member-allowed() {
	local rel=$1
	local member=$2
	local entry archive_pattern member_pattern

	for entry in ${QA_POLICY_ARCHIVE_DUPLICATE_MEMBER_ALLOW}; do
		if [[ ${entry} == *:* ]]; then
			archive_pattern=${entry%%:*}
			member_pattern=${entry#*:}
			[[ -n ${archive_pattern} && -n ${member_pattern} ]] || continue
			[[ ${rel} == "${archive_pattern}" && ${member} == "${member_pattern}" ]] && return 0
		else
			[[ ${rel} == "${entry}" ]] && return 0
		fi
	done

	return 1
}

qa-archive-empty-expected() {
	local rel=$1
	local re

	for re in ${QA_POLICY_ARCHIVE_EXPECT_EMPTY}; do
		[[ ${rel} =~ ${re} ]] && return 0
	done
	return 1
}

qa-archive-sanitize() {
	qa-report-domain-begin archive

	local -a archives=( "${QA_DISCOVER_ARCHIVES[@]}" )
	local archive had_index
	local -i archives_scanned=${#archives[@]} indexes_fixed=0 thin_archives_rewritten=0

	for archive in "${archives[@]}"; do
		had_index=0
		_bu-has-index "${archive}" && had_index=1

		if _bu-is-thin "${archive}" && [[ ${QA_POLICY_ARCHIVE_ALLOW_THIN} == 0 ]]; then
			_bu-convert-thin "${archive}"
			(( thin_archives_rewritten += 1 ))
		fi

		if [[ ${QA_POLICY_ARCHIVE_REQUIRE_INDEX} == 1 || ${had_index} == 0 ]]; then
			qa-archive-fix-index "${archive}"
			if [[ ${had_index} == 0 ]] && qa-archive-check-index "${archive}"; then
				(( indexes_fixed += 1 ))
			fi
		fi
	done

	qa-report-domain-stat archive archives_scanned "${archives_scanned}"
	qa-report-domain-stat archive indexes_fixed "${indexes_fixed}"
	qa-report-domain-stat archive thin_archives_rewritten "${thin_archives_rewritten}"
}

qa-archive-assert() {
	qa-report-domain-begin archive

	local -a archives=( "${QA_DISCOVER_ARCHIVES[@]}" )
	local -a scripts=( "${QA_DISCOVER_LDSCRIPTS[@]}" )
	local archive script rel members dup
	local ar_cmd
	local -i archives_scanned=${#archives[@]} ldscripts_scanned=0
	local -i empty_archives=0 expected_empty_archives=0 duplicate_member_names=0 allowed_duplicate_member_names=0
	local mode=${QA_POLICY_ARCHIVE_MODE}

	ar_cmd=$(tc-getAR)

	for archive in "${archives[@]}"; do
		rel=$(_qa-policy-relpath "${archive}")

		if ! members=$("${ar_cmd}" t "${archive}" 2>/dev/null); then
			_qa-report-record-mode archive "${mode}" unreadable-archive "${rel}" "ar could not read archive contents"
			continue
		fi

		local -i member_count=0
		if [[ -n ${members//$'\n'/} ]]; then
			member_count=$(printf '%s\n' "${members}" | sed '/^$/d' | wc -l)
		fi

		if qa-archive-empty-expected "${rel}"; then
			if (( member_count == 0 )); then
				(( expected_empty_archives += 1 ))
				qa-report-note archive expected-empty-archive "${rel}" "archive is empty as expected"
			else
				_qa-report-record-mode archive "${mode}" unexpected-nonempty-archive "${rel}" "expected empty archive, found ${member_count} member(s)"
			fi
		elif (( member_count == 0 )); then
			(( empty_archives += 1 ))
			_qa-report-record-mode archive "${mode}" empty-archive "${rel}" "archive has no members"
		fi

		while IFS= read -r dup; do
			[[ -n ${dup} ]] || continue
			if qa-archive-duplicate-member-allowed "${rel}" "${dup}"; then
				(( allowed_duplicate_member_names += 1 ))
				qa-report-note archive allowed-duplicate-member-name "${rel}" "duplicate member name allowed: ${dup}"
				continue
			fi
			(( duplicate_member_names += 1 ))
			_qa-report-record-mode archive "${mode}" duplicate-member-name "${rel}" "duplicate member name: ${dup}"
		done < <(qa-archive-list-duplicate-members "${archive}")

		if qa-archive-check-thin "${archive}" && [[ ${QA_POLICY_ARCHIVE_ALLOW_THIN} == 0 ]]; then
			_qa-report-record-mode archive "${mode}" thin-archive "${rel}" "thin archives are forbidden"
		fi

		if [[ ${QA_POLICY_ARCHIVE_REQUIRE_INDEX} == 1 ]] && ! qa-archive-check-index "${archive}"; then
			_qa-report-record-mode archive "${mode}" missing-index "${rel}" "archive index missing"
		fi

		if [[ ${QA_POLICY_LTO_STRIP_ARCHIVE_IR} == 1 ]] && _lto-policy-has-ir "${archive}"; then
			_qa-report-record-mode archive "${mode}" ir-remnant "${rel}" "unexpected LTO IR payload remains in archive"
		fi
	done

	if [[ ${QA_POLICY_ARCHIVE_CHECK_LDSCRIPTS} == 1 ]]; then
		for script in "${scripts[@]}"; do
			(( ldscripts_scanned += 1 ))
			rel=$(_qa-policy-relpath "${script}")
			qa-archive-check-ldscript "${script}" "${rel}"
		done
	fi

	qa-report-domain-stat archive archives_scanned "${archives_scanned}"
	qa-report-domain-stat archive empty_archives "${empty_archives}"
	qa-report-domain-stat archive expected_empty_archives "${expected_empty_archives}"
	qa-report-domain-stat archive duplicate_member_names "${duplicate_member_names}"
	qa-report-domain-stat archive allowed_duplicate_member_names "${allowed_duplicate_member_names}"
	qa-report-domain-stat archive ldscripts_scanned "${ldscripts_scanned}"
}

fi

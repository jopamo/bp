# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-rpath.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal RPATH sanitize and assertion helpers for qa-policy


if [[ -z ${_QA_RPATH_ECLASS:-} ]] ; then
_QA_RPATH_ECLASS=1

inherit qa-report rpath-sanitizer

_qa-rpath-split() {
	local value=$1
	local -n out_ref=$2

	out_ref=()
	[[ -n ${value} ]] || return 0

	local IFS=':'
	read -r -a out_ref <<< "${value}"
}

_qa-rpath-join() {
	local -n in_ref=$1
	local IFS=':'
	printf '%s\n' "${in_ref[*]}"
}

_qa-rpath-entry-allowed() {
	local entry=$1
	local re

	for re in ${QA_POLICY_RPATH_ALLOW}; do
		[[ ${entry} =~ ${re} ]] && return 0
	done
	return 1
}

_qa-rpath-empty-entry-present() {
	local value=$1
	[[ ${value} == :* || ${value} == *: || ${value} == *::* ]]
}

qa-rpath-list-elf() {
	printf '%s\n' "${QA_DISCOVER_ELF_FILES[@]}"
}

qa-rpath-clean-one() {
	local file=$1
	local value=$2
	local patchelf_cmd

	patchelf_cmd=$(type -P patchelf || true)
	[[ -n ${patchelf_cmd} ]] || die "qa-rpath: patchelf is required"

	if [[ -n ${value} ]]; then
		"${patchelf_cmd}" --set-rpath "${value}" "${file}" || die "qa-rpath: failed to rewrite ${file}"
	else
		"${patchelf_cmd}" --remove-rpath "${file}" || die "qa-rpath: failed to remove rpath from ${file}"
	fi
}

qa-rpath-check-one() {
	local file=$1
	local rel=$2
	local current=$3
	local -a entries=()
	local entry

	if _qa-rpath-empty-entry-present "${current}" && [[ ${QA_POLICY_RPATH_ALLOW_EMPTY} == 0 ]]; then
		_qa-report-record-mode rpath "${QA_POLICY_RPATH_MODE}" empty-entry "${rel}" "empty RPATH or RUNPATH entry remains: ${current}"
		return 0
	fi

	_qa-rpath-split "${current}" entries
	for entry in "${entries[@]}"; do
		if [[ -z ${entry} ]]; then
			continue
		fi
		if _rpath-has-build-leak "${entry}"; then
			_qa-report-record-mode rpath "${QA_POLICY_RPATH_MODE}" build-path "${rel}" "build path leaked into RPATH or RUNPATH: ${entry}"
			return 0
		fi
		if ! _qa-rpath-entry-allowed "${entry}"; then
			_qa-report-record-mode rpath "${QA_POLICY_RPATH_MODE}" bad-rpath "${rel}" "disallowed RPATH or RUNPATH entry remains: ${entry}"
			return 0
		fi
	done
}

qa-rpath-sanitize() {
	qa-report-domain-begin rpath

	local -i elfs_scanned=0 cleaned_paths=0 files_modified=0
	local file rel current new_value entry
	local -a entries=() kept=()

	for file in "${QA_DISCOVER_ELF_FILES[@]}"; do
		(( elfs_scanned += 1 ))
		current=$(_rpath-get "${file}")
		[[ -n ${current} ]] || continue

		kept=()
		_qa-rpath-split "${current}" entries
		for entry in "${entries[@]}"; do
			if [[ -z ${entry} ]]; then
				if [[ ${QA_POLICY_RPATH_ALLOW_EMPTY} == 1 ]]; then
					kept+=( "${entry}" )
				else
					(( cleaned_paths += 1 ))
				fi
				continue
			fi

			if _rpath-has-build-leak "${entry}"; then
				(( cleaned_paths += 1 ))
				continue
			fi

			if _qa-rpath-entry-allowed "${entry}"; then
				kept+=( "${entry}" )
				continue
			fi

			(( cleaned_paths += 1 ))
		done

		new_value=$(_qa-rpath-join kept)
		[[ ${new_value} == "${current}" ]] && continue
		[[ ${QA_POLICY_RPATH_CLEAN} == 1 ]] || continue

		qa-rpath-clean-one "${file}" "${new_value}"
		(( files_modified += 1 ))
		rel=$(_qa-policy-relpath "${file}")
		[[ -n ${new_value} ]] || qa-report-note rpath cleaned "${rel}" "removed disallowed RPATH or RUNPATH entries"
	done

	qa-report-domain-stat rpath elfs_scanned "${elfs_scanned}"
	qa-report-domain-stat rpath cleaned_paths "${cleaned_paths}"
	qa-report-domain-stat rpath files_modified "${files_modified}"
}

qa-rpath-assert() {
	qa-report-domain-begin rpath

	local -i elfs_scanned=0
	local file rel current

	for file in "${QA_DISCOVER_ELF_FILES[@]}"; do
		(( elfs_scanned += 1 ))
		current=$(_rpath-get "${file}")
		[[ -n ${current} ]] || continue

		rel=$(_qa-policy-relpath "${file}")
		qa-rpath-check-one "${file}" "${rel}" "${current}"
	done

	qa-report-domain-stat rpath elfs_scanned "${elfs_scanned}"
}

fi

# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-shebang.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal shebang validation helpers for qa-policy

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_QA_SHEBANG_ECLASS:-} ]] ; then
_QA_SHEBANG_ECLASS=1

inherit qa-report

_qa-shebang-read-line() {
	local file=$1
	local line=

	IFS= read -r line < "${file}" || [[ -n ${line} ]] || return 1
	line=${line%$'\r'}
	[[ ${line} == '#!'* ]] || return 1

	printf '%s\n' "${line}"
}

_qa-shebang-has-build-path() {
	local body=$1
	[[ ${body} == *'/var/tmp/'* || ${body} == *'/tmp/portage/'* ]]
}

_qa-shebang-is-python-unversioned() {
	local line=$1

	if [[ ${line} =~ ^#![[:space:]]*/usr/bin/python([[:space:]]|$) ]]; then
		return 0
	fi

	if [[ ${line} =~ ^#![[:space:]]*/usr/bin/env[[:space:]]+python([[:space:]]|$) ]]; then
		return 0
	fi

	return 1
}

_qa-shebang-rewrite-python-unversioned-line() {
	local line=$1

	printf '%s\n' "${line}" | sed -E \
		-e 's@^#![[:space:]]*/usr/bin/python([[:space:]]|$)@#!/usr/bin/python3\1@' \
		-e 's@^#![[:space:]]*/usr/bin/env[[:space:]]+python([[:space:]]|$)@#!/usr/bin/env python3\1@'
}

_qa-shebang-rewrite-first-line() {
	local file=$1
	local new_line=$2
	local tmp

	tmp=$(mktemp "${T:-/tmp}/qa-shebang.XXXXXX") || die "qa-shebang: mktemp failed"
	{
		printf '%s\n' "${new_line}"
		tail -n +2 "${file}" || die "qa-shebang: failed reading ${file}"
	} > "${tmp}" || die "qa-shebang: failed writing temporary file for ${file}"

	cat "${tmp}" > "${file}" || die "qa-shebang: failed rewriting ${file}"
	rm -f -- "${tmp}" || die "qa-shebang: failed removing temporary file ${tmp}"
}

qa-shebang-list() {
	local file
	local line

	for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
		line=$(_qa-shebang-read-line "${file}") || continue
		[[ -n ${line} ]] && printf '%s\n' "${file}"
	done
}

qa-shebang-sanitize() {
	qa-report-domain-begin shebang

	local file rel line new_line
	local -i files_scanned=0 shebang_files=0 python_rewrites=0

	for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
		(( files_scanned += 1 ))
		line=$(_qa-shebang-read-line "${file}") || continue
		(( shebang_files += 1 ))

		[[ ${QA_POLICY_SHEBANG_SANITIZE} == 1 ]] || continue
		_qa-shebang-is-python-unversioned "${line}" || continue

		new_line=$(_qa-shebang-rewrite-python-unversioned-line "${line}")
		[[ ${new_line} == "${line}" ]] && continue

		_qa-shebang-rewrite-first-line "${file}" "${new_line}"
		(( python_rewrites += 1 ))
		rel=$(_qa-policy-relpath "${file}")
		qa-report-note shebang sanitized-python "${rel}" "rewrote unversioned python shebang to python3"
	done

	qa-report-domain-stat shebang files_scanned "${files_scanned}"
	qa-report-domain-stat shebang shebang_files "${shebang_files}"
	qa-report-domain-stat shebang python_rewrites "${python_rewrites}"
}

qa-shebang-assert() {
	qa-report-domain-begin shebang

	local file rel line body interpreter env_target
	local -i files_scanned=0 shebang_files=0

	for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
		(( files_scanned += 1 ))
		line=$(_qa-shebang-read-line "${file}") || continue
		(( shebang_files += 1 ))
		rel=$(_qa-policy-relpath "${file}")
		body=${line#\#!}
		read -r interpreter env_target _ <<< "${body}"

		if [[ -z ${interpreter} || ${interpreter} != /* ]]; then
			_qa-report-record-mode shebang "${QA_POLICY_SHEBANG_MODE}" bad-shebang "${rel}" "interpreter path must be absolute"
		elif [[ ${interpreter} == /usr/bin/env || ${interpreter} == /bin/env ]]; then
			[[ -n ${env_target} ]] || \
				_qa-report-record-mode shebang "${QA_POLICY_SHEBANG_MODE}" bad-shebang "${rel}" "env shebang is missing the target command"
		fi

		if _qa-shebang-has-build-path "${body}"; then
			_qa-report-record-mode shebang "${QA_POLICY_SHEBANG_MODE}" build-path-shebang "${rel}" "shebang references a build path"
		fi

		if _qa-shebang-is-python-unversioned "${line}"; then
			_qa-report-record-mode shebang "${QA_POLICY_SHEBANG_MODE}" python-unversioned "${rel}" "use a versioned python interpreter in shebangs"
		fi
	done

	qa-report-domain-stat shebang files_scanned "${files_scanned}"
	qa-report-domain-stat shebang shebang_files "${shebang_files}"
}

fi

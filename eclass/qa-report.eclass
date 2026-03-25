# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-report.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Structured finding collector and printer for qa-policy
# @DESCRIPTION:
# Internal reporting backbone used by qa-policy and its helper eclasses.


if [[ -z ${_QA_REPORT_ECLASS:-} ]] ; then
_QA_REPORT_ECLASS=1

_qa-report-package-label() {
	if [[ -n ${CATEGORY-} && -n ${PF-} ]]; then
		printf '%s/%s\n' "${CATEGORY}" "${PF}"
		return 0
	fi

	printf '%s\n' "${PF:-unknown}"
}

_qa-report-set-stage() {
	case ${1} in
		sanitize|assert) ;;
		*) die "qa-report: invalid stage ${1}" ;;
	esac

	_QA_REPORT_STAGE=${1}
}

_qa-report-domain-array-name() {
	case ${1} in
		sanitize) printf '%s\n' _QA_REPORT_SANITIZE_DOMAINS ;;
		assert) printf '%s\n' _QA_REPORT_ASSERT_DOMAINS ;;
		*) die "qa-report: invalid stage ${1}" ;;
	esac
}

_qa-report-domain-finding-count() {
	local stage=$1
	local domain=$2
	local record record_stage record_domain severity code path message
	local -i count=0

	for record in "${_QA_REPORT_FINDINGS[@]}"; do
		IFS='|' read -r record_stage record_domain severity code path message <<< "${record}"
		[[ ${record_stage} == "${stage}" && ${record_domain} == "${domain}" ]] || continue
		(( count += 1 ))
	done

	printf '%s\n' "${count}"
}

_qa-report-print-domain() {
	local stage=$1
	local domain=$2
	local record record_stage record_domain severity code path message
	local entry count

	einfo "  ${domain}:"

	for entry in "${_QA_REPORT_STAT_ORDER[@]}"; do
		IFS='|' read -r record_stage record_domain code <<< "${entry}"
		[[ ${record_stage} == "${stage}" && ${record_domain} == "${domain}" ]] || continue
		einfo "    ${code}: ${_QA_REPORT_STATS["${entry}"]}"
	done

	count=$(_qa-report-domain-finding-count "${stage}" "${domain}")
	if [[ ${count} -eq 0 ]]; then
		[[ ${QA_POLICY_SHOW_CLEAN-0} == 1 ]] && einfo "    clean: yes"
		return 0
	fi

	for record in "${_QA_REPORT_FINDINGS[@]}"; do
		IFS='|' read -r record_stage record_domain severity code path message <<< "${record}"
		[[ ${record_stage} == "${stage}" && ${record_domain} == "${domain}" ]] || continue

		if [[ -n ${path} ]]; then
			einfo "    ${severity^^} ${code}: ${path}"
		else
			einfo "    ${severity^^} ${code}"
		fi

		[[ -n ${message} ]] && einfo "         ${message}"
	done
}

_qa-report-print-stage() {
	local stage=$1
	local array_name
	array_name=$(_qa-report-domain-array-name "${stage}")
	local -n domains_ref=${array_name}
	local domain

	einfo "${stage}:"
	for domain in "${domains_ref[@]}"; do
		_qa-report-print-domain "${stage}" "${domain}"
	done
}

_qa-report-record-mode() {
	local domain=$1
	local mode=$2
	local code=$3
	local path=$4
	local message=$5

	case ${mode} in
		off)
			return 0
			;;
		report)
			qa-report-note "${domain}" "${code}" "${path}" "${message}"
			;;
		warn)
			qa-report-warn "${domain}" "${code}" "${path}" "${message}"
			;;
		fail)
			qa-report-fail "${domain}" "${code}" "${path}" "${message}"
			;;
		*)
			die "qa-report: invalid mode ${mode}"
			;;
	esac
}

qa-report-init() {
	declare -ga _QA_REPORT_FINDINGS=()
	declare -ga _QA_REPORT_SANITIZE_DOMAINS=()
	declare -ga _QA_REPORT_ASSERT_DOMAINS=()
	declare -ga _QA_REPORT_STAT_ORDER=()
	declare -gA _QA_REPORT_DOMAIN_SEEN=()
	declare -gA _QA_REPORT_STAT_SEEN=()
	declare -gA _QA_REPORT_STATS=()

	_QA_REPORT_STAGE=
	_QA_REPORT_REPORTS=0
	_QA_REPORT_WARNINGS=0
	_QA_REPORT_FAILURES=0
}

qa-report-domain-begin() {
	local domain=$1
	local key array_name

	[[ -n ${_QA_REPORT_STAGE-} ]] || die "qa-report: stage not set"

	key="${_QA_REPORT_STAGE}|${domain}"
	[[ -n ${_QA_REPORT_DOMAIN_SEEN["${key}"]:-} ]] && return 0
	_QA_REPORT_DOMAIN_SEEN["${key}"]=1

	array_name=$(_qa-report-domain-array-name "${_QA_REPORT_STAGE}")
	local -n domains_ref=${array_name}
	domains_ref+=( "${domain}" )
}

qa-report-domain-stat() {
	local domain=$1
	local stat=$2
	local value=$3
	local key

	qa-report-domain-begin "${domain}"
	key="${_QA_REPORT_STAGE}|${domain}|${stat}"
	if [[ -z ${_QA_REPORT_STAT_SEEN["${key}"]:-} ]]; then
		_QA_REPORT_STAT_SEEN["${key}"]=1
		_QA_REPORT_STAT_ORDER+=( "${key}" )
	fi
	_QA_REPORT_STATS["${key}"]=${value}
}

qa-report-record() {
	local domain=$1
	local severity=$2
	local code=$3
	local path=$4
	local message=$5

	qa-report-domain-begin "${domain}"
	_QA_REPORT_FINDINGS+=( "${_QA_REPORT_STAGE}|${domain}|${severity}|${code}|${path}|${message}" )

	case ${severity} in
		report) (( _QA_REPORT_REPORTS += 1 )) ;;
		warn) (( _QA_REPORT_WARNINGS += 1 )) ;;
		fail) (( _QA_REPORT_FAILURES += 1 )) ;;
		*) die "qa-report: invalid severity ${severity}" ;;
	esac
}

qa-report-note() {
	qa-report-record "$1" report "$2" "$3" "$4"
}

qa-report-warn() {
	qa-report-record "$1" warn "$2" "$3" "$4"
}

qa-report-fail() {
	qa-report-record "$1" fail "$2" "$3" "$4"
}

qa-report-print() {
	case ${QA_POLICY_SUMMARY-} in
		full|short) ;;
		*) die "qa-report: invalid QA_POLICY_SUMMARY=${QA_POLICY_SUMMARY-}" ;;
	esac

	einfo "qa-policy: $(_qa-report-package-label)"

	if [[ ${QA_POLICY_SUMMARY-} == full ]]; then
		_qa-report-print-stage sanitize
		_qa-report-print-stage assert
	fi

	einfo "summary:"
	einfo "  reports: ${_QA_REPORT_REPORTS}"
	einfo "  warnings: ${_QA_REPORT_WARNINGS}"
	einfo "  failures: ${_QA_REPORT_FAILURES}"

	if [[ ${_QA_REPORT_FAILURES} -gt 0 ]]; then
		eerror "  result: FAIL"
	elif [[ ${_QA_REPORT_WARNINGS} -gt 0 ]]; then
		ewarn "  result: WARN"
	else
		einfo "  result: PASS"
	fi
}

qa-report-has-failures() {
	[[ ${_QA_REPORT_FAILURES-0} -gt 0 ]]
}

qa-report-has-warnings() {
	[[ ${_QA_REPORT_WARNINGS-0} -gt 0 ]]
}

fi

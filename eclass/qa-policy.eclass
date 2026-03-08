# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-policy.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Shared policy wrapper for linker, LTO, and install QA checks
# @DESCRIPTION:
# Provides compact setup and post-install wrappers used by migrated ebuilds

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_QA_POLICY_ECLASS} ]] ; then
_QA_POLICY_ECLASS=1

inherit emoji linker-policy lto-policy binutils-sanitizer rpath-sanitizer pkgconfig-sanity elf-qa

BDEPEND+=" app-dev/patchelf"

: "${QA_POLICY_LP_MODE:=compat}"
: "${QA_POLICY_LTO_WITH_STATIC:=fat+strip}"
: "${QA_POLICY_LTO_WITHOUT_STATIC:=none}"
: "${QA_POLICY_ARCHIVE_MODE:=fail}"
: "${QA_POLICY_RPATH_MODE:=fail}"
: "${QA_POLICY_PC_MODE:=warn}"
: "${QA_POLICY_ELF_MODE:=report}"
: "${QA_POLICY_LINKER_MODE:=fail}"
: "${QA_POLICY_PC_FIXUP:=0}"

_QA_POLICY_LINKER_CONFIGURED=0
_QA_POLICY_LAST_LTO_MODE=
_QA_POLICY_REPORTS=0
_QA_POLICY_WARNINGS=0
_QA_POLICY_FAILURES=0

_qa-policy-validate-mode() {
	case ${1} in
		off|report|warn|fail) ;;
		*) die "qa-policy: invalid mode ${1}" ;;
	esac
}

_qa-policy-reset-results() {
	_QA_POLICY_REPORTS=0
	_QA_POLICY_WARNINGS=0
	_QA_POLICY_FAILURES=0
}

_qa-policy-record-result() {
	local subsystem=$1
	local mode=$2

	case ${mode} in
		report)
			(( _QA_POLICY_REPORTS += 1 ))
			log_info "qa-policy: ${subsystem} findings recorded"
			;;
		warn)
			(( _QA_POLICY_WARNINGS += 1 ))
			log_warn "qa-policy: ${subsystem} findings recorded"
			;;
		fail)
			(( _QA_POLICY_FAILURES += 1 ))
			log_err "qa-policy: ${subsystem} findings recorded"
			;;
	esac
}

_qa-policy-run-check() {
	local subsystem=$1
	local mode=$2
	shift 2

	_qa-policy-validate-mode "${mode}"
	[[ ${mode} == off ]] && return 0

	if "$@"; then
		return 0
	fi

	_qa-policy-record-result "${subsystem}" "${mode}"
	return 0
}

_qa-policy-archive-check() {
	local rc=0

	bu-archive-check "$@" || rc=1
	if [[ ${BU_CHECK_LDSCRIPTS} == 1 ]]; then
		bu-ldscript-check "$@" || rc=1
	fi

	return ${rc}
}

_qa-policy-install-sanitize() {
	log_info "qa-policy: sanitize phase"

	if [[ ${QA_POLICY_ARCHIVE_MODE} != off ]]; then
		lto-postinstall-sanitize "$@"
		bu-archive-fixup "$@"
	fi

	if [[ ${QA_POLICY_RPATH_MODE} != off ]]; then
		rpath-clean "$@"
	fi

	if [[ ${QA_POLICY_PC_MODE} != off && ${QA_POLICY_PC_FIXUP} == 1 ]]; then
		pc-fixup "$@"
	fi
}

_qa-policy-install-assert() {
	log_info "qa-policy: assert phase"

	_qa-policy-run-check archive "${QA_POLICY_ARCHIVE_MODE}" _qa-policy-archive-check "$@"
	_qa-policy-run-check rpath "${QA_POLICY_RPATH_MODE}" rpath-check "$@"
	_qa-policy-run-check pkgconfig "${QA_POLICY_PC_MODE}" pc-validate "$@"

	if [[ ${QA_POLICY_ELF_MODE} != off ]]; then
		ELFQA_MODE=report
		_qa-policy-run-check elf "${QA_POLICY_ELF_MODE}" elfqa-scan "$@"
	fi

	_qa-policy-run-check linker "${QA_POLICY_LINKER_MODE}" lp-check-linker "$@"
}

_qa-policy-install-finalize() {
	if [[ ${_QA_POLICY_FAILURES} -gt 0 ]]; then
		log_err "qa-policy: reports=${_QA_POLICY_REPORTS} warnings=${_QA_POLICY_WARNINGS} failures=${_QA_POLICY_FAILURES}"
		die "qa-policy-install: policy failures detected"
	fi

	if [[ ${_QA_POLICY_WARNINGS} -gt 0 ]]; then
		log_warn "qa-policy: reports=${_QA_POLICY_REPORTS} warnings=${_QA_POLICY_WARNINGS} failures=${_QA_POLICY_FAILURES}"
		return 0
	fi

	if [[ ${_QA_POLICY_REPORTS} -gt 0 ]]; then
		log_info "qa-policy: reports=${_QA_POLICY_REPORTS} warnings=${_QA_POLICY_WARNINGS} failures=${_QA_POLICY_FAILURES}"
		return 0
	fi

	log_ok "qa-policy: reports=0 warnings=0 failures=0"
}

# @FUNCTION: qa-policy-configure
# @USAGE: [lto_mode]
# @DESCRIPTION:
# Apply shared linker and LTO policy setup
qa-policy-configure() {
	local lto_mode=${1:-}

	if [[ ${_QA_POLICY_LINKER_CONFIGURED} != 1 ]]; then
		LP_MODE=${QA_POLICY_LP_MODE}
		lp-setup
		_QA_POLICY_LINKER_CONFIGURED=1
	fi

	if [[ -z ${lto_mode} ]]; then
		if in_iuse static-libs; then
			if use static-libs; then
				lto_mode=${QA_POLICY_LTO_WITH_STATIC}
			else
				lto_mode=${QA_POLICY_LTO_WITHOUT_STATIC}
			fi
		else
			lto_mode=${QA_POLICY_LTO_WITHOUT_STATIC}
		fi
	fi

	if [[ ${_QA_POLICY_LAST_LTO_MODE} != ${lto_mode} ]]; then
		LTO_POLICY_MODE=${lto_mode}
		lto-setup
		_QA_POLICY_LAST_LTO_MODE=${lto_mode}
	fi

	log_info "qa-policy: configure linker=${QA_POLICY_LP_MODE} lto=${lto_mode}"
}

# @FUNCTION: qa-policy-install
# @USAGE: [path] [more]
# @DESCRIPTION:
# Apply shared sanitize and assert chain
qa-policy-install() {
	_qa-policy-validate-mode "${QA_POLICY_ARCHIVE_MODE}"
	_qa-policy-validate-mode "${QA_POLICY_RPATH_MODE}"
	_qa-policy-validate-mode "${QA_POLICY_PC_MODE}"
	_qa-policy-validate-mode "${QA_POLICY_ELF_MODE}"
	_qa-policy-validate-mode "${QA_POLICY_LINKER_MODE}"

	_qa-policy-reset-results
	_qa-policy-install-sanitize "$@"
	_qa-policy-install-assert "$@"
	_qa-policy-install-finalize
}

fi

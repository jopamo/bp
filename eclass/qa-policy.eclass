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

inherit linker-policy lto-policy binutils-sanitizer rpath-sanitizer pkgconfig-sanity elf-qa

: "${QA_POLICY_LP_MODE:=compat}"
: "${QA_POLICY_LTO_WITH_STATIC:=fat+strip}"
: "${QA_POLICY_LTO_WITHOUT_STATIC:=none}"
: "${QA_POLICY_ELFQA_MODE:=report}"
: "${QA_POLICY_PC_STRICT:=0}"

# @FUNCTION: qa-policy-configure
# @USAGE: [lto_mode]
# @DESCRIPTION:
# Apply shared linker and LTO policy setup
qa-policy-configure() {
	local lto_mode=${1:-}

	LP_MODE=${QA_POLICY_LP_MODE}
	lp-setup

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

	LTO_POLICY_MODE=${lto_mode}
	lto-setup
}

# @FUNCTION: qa-policy-install
# @USAGE: [path] [more]
# @DESCRIPTION:
# Apply shared sanitize and assert chain
qa-policy-install() {
	ELFQA_MODE=${QA_POLICY_ELFQA_MODE}
	PC_STRICT=${QA_POLICY_PC_STRICT}

	lto-postinstall-sanitize "$@"
	bu-archive-fixup "$@"
	bu-assert "$@"
	rpath-clean "$@"
	rpath-assert-clean "$@"
	pc-assert "$@"
	elfqa-assert "$@"
	lp-assert-linker "$@"
}

fi

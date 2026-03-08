# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-policy.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Public facade for staged package QA policy
# @DESCRIPTION:
# Exposes configure, compile, and install entry points while delegating setup,
# sanitize, assertion, and reporting to internal qa-* eclasses.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_QA_POLICY_ECLASS} ]] ; then
_QA_POLICY_ECLASS=1

inherit qa-report qa-linker qa-lto qa-archive qa-rpath qa-pkgconfig qa-elf

BDEPEND+=" app-dev/patchelf"

_qa-policy-relpath() {
	local file=$1
	local root=${ED%/}

	if [[ -n ${root} && ${file} == "${root}"/* ]]; then
		printf '%s\n' "${file#${root}}"
		return 0
	fi

	printf '%s\n' "${file}"
}

_qa-policy-validate-bool() {
	local name=$1
	local value=${!name}

	case ${value} in
		0|1) ;;
		*) die "qa-policy: ${name} must be 0 or 1, got ${value}" ;;
	esac
}

_qa-policy-validate-mode() {
	case ${1} in
		off|report|warn|fail) ;;
		*) die "qa-policy: invalid mode ${1}" ;;
	esac
}

_qa-policy-validate-pattern-list() {
	local name=$1
	local re rc

	for re in ${!name}; do
		if [[ '' =~ ${re} ]] 2>/dev/null; then
			rc=0
		else
			rc=$?
		fi
		[[ ${rc} -ne 2 ]] || die "qa-policy: invalid regex in ${name}: ${re}"
	done
}

_qa-policy-path-skipped() {
	local rel=$1
	local re

	for re in ${QA_POLICY_SKIP_PATHS}; do
		[[ ${rel} =~ ${re} ]] && return 0
	done
	return 1
}

_qa-policy-apply-defaults() {
	: "${QA_POLICY_ENABLE:=1}"
	: "${QA_POLICY_PROFILE:=base}"
	: "${QA_POLICY_FAIL_FAST:=0}"
	: "${QA_POLICY_SHOW_CLEAN:=0}"
	: "${QA_POLICY_SUMMARY:=full}"
	: "${QA_POLICY_SANITIZE:=1}"
	: "${QA_POLICY_ASSERT:=1}"
	: "${QA_POLICY_SKIP_PATHS:=}"

	case ${QA_POLICY_PROFILE} in
		base)
			: "${QA_POLICY_LINKER_MODE:=fail}"
			: "${QA_POLICY_LTO_MODE:=fail}"
			: "${QA_POLICY_ARCHIVE_MODE:=fail}"
			: "${QA_POLICY_RPATH_MODE:=fail}"
			: "${QA_POLICY_PKGCONFIG_MODE:=warn}"
			: "${QA_POLICY_ELF_MODE:=report}"
			;;
		strict)
			: "${QA_POLICY_LINKER_MODE:=fail}"
			: "${QA_POLICY_LTO_MODE:=fail}"
			: "${QA_POLICY_ARCHIVE_MODE:=fail}"
			: "${QA_POLICY_RPATH_MODE:=fail}"
			: "${QA_POLICY_PKGCONFIG_MODE:=fail}"
			: "${QA_POLICY_ELF_MODE:=fail}"
			;;
		dev)
			: "${QA_POLICY_LINKER_MODE:=warn}"
			: "${QA_POLICY_LTO_MODE:=warn}"
			: "${QA_POLICY_ARCHIVE_MODE:=warn}"
			: "${QA_POLICY_RPATH_MODE:=warn}"
			: "${QA_POLICY_PKGCONFIG_MODE:=warn}"
			: "${QA_POLICY_ELF_MODE:=report}"
			;;
		*)
			die "qa-policy: invalid QA_POLICY_PROFILE=${QA_POLICY_PROFILE}"
			;;
	esac

	: "${QA_POLICY_LINKER_EXPECTED:=auto}"
	: "${QA_POLICY_LINKER_ALLOW:=}"
	: "${QA_POLICY_LTO_FLAVOR:=auto}"
	: "${QA_POLICY_LTO_STRIP_ARCHIVE_IR:=1}"
	: "${QA_POLICY_ARCHIVE_ALLOW_THIN:=0}"
	: "${QA_POLICY_ARCHIVE_REQUIRE_INDEX:=1}"
	: "${QA_POLICY_ARCHIVE_CHECK_LDSCRIPTS:=1}"
	: "${QA_POLICY_RPATH_ALLOW:=}"
	: "${QA_POLICY_RPATH_CLEAN:=1}"
	: "${QA_POLICY_RPATH_ALLOW_EMPTY:=0}"
	: "${QA_POLICY_PKGCONFIG_ALLOW_HOST_PATHS:=0}"
	: "${QA_POLICY_PKGCONFIG_ALLOW_MISSING_REQUIRES:=0}"
	: "${QA_POLICY_PKGCONFIG_ALLOW_NONEXISTENT_LIBDIRS:=0}"
	: "${QA_POLICY_ELF_ALLOW_TEXTREL:=}"
	: "${QA_POLICY_ELF_ALLOW_EXECSTACK:=}"
	: "${QA_POLICY_ELF_ALLOW_MISSING_SONAME:=}"
	: "${QA_POLICY_ELF_ALLOW_INTERP:=}"
	: "${QA_POLICY_ELF_REQUIRE_GNU_STACK:=1}"
	: "${QA_POLICY_ELF_REQUIRE_RELRO:=0}"
	: "${QA_POLICY_ELF_REQUIRE_NOW:=0}"
	: "${QA_POLICY_ELF_REQUIRE_PIE:=0}"
}

_qa-policy-init() {
	_qa-policy-apply-defaults
	qa-report-init

	declare -ga QA_DISCOVER_ALL_FILES=()
	declare -ga QA_DISCOVER_ELF_FILES=()
	declare -ga QA_DISCOVER_ARCHIVES=()
	declare -ga QA_DISCOVER_PKGCONFIG=()
	declare -ga QA_DISCOVER_LDSCRIPTS=()
}

_qa-policy-validate-config() {
	local var

	for var in \
		QA_POLICY_ENABLE \
		QA_POLICY_FAIL_FAST \
		QA_POLICY_SHOW_CLEAN \
		QA_POLICY_SANITIZE \
		QA_POLICY_ASSERT \
		QA_POLICY_LTO_STRIP_ARCHIVE_IR \
		QA_POLICY_ARCHIVE_ALLOW_THIN \
		QA_POLICY_ARCHIVE_REQUIRE_INDEX \
		QA_POLICY_ARCHIVE_CHECK_LDSCRIPTS \
		QA_POLICY_RPATH_CLEAN \
		QA_POLICY_RPATH_ALLOW_EMPTY \
		QA_POLICY_PKGCONFIG_ALLOW_HOST_PATHS \
		QA_POLICY_PKGCONFIG_ALLOW_MISSING_REQUIRES \
		QA_POLICY_PKGCONFIG_ALLOW_NONEXISTENT_LIBDIRS \
		QA_POLICY_ELF_REQUIRE_GNU_STACK \
		QA_POLICY_ELF_REQUIRE_RELRO \
		QA_POLICY_ELF_REQUIRE_NOW \
		QA_POLICY_ELF_REQUIRE_PIE; do
		_qa-policy-validate-bool "${var}"
	done

	for var in \
		QA_POLICY_LINKER_MODE \
		QA_POLICY_LTO_MODE \
		QA_POLICY_ARCHIVE_MODE \
		QA_POLICY_RPATH_MODE \
		QA_POLICY_PKGCONFIG_MODE \
		QA_POLICY_ELF_MODE; do
		_qa-policy-validate-mode "${!var}"
	done

	case ${QA_POLICY_SUMMARY} in
		full|short) ;;
		*) die "qa-policy: invalid QA_POLICY_SUMMARY=${QA_POLICY_SUMMARY}" ;;
	esac

	case ${QA_POLICY_LINKER_EXPECTED} in
		auto|bfd|lld|mold|'') ;;
		*) die "qa-policy: invalid QA_POLICY_LINKER_EXPECTED=${QA_POLICY_LINKER_EXPECTED}" ;;
	esac

	case ${QA_POLICY_LTO_FLAVOR} in
		auto|none|full|thin|thin+cache|fat+strip) ;;
		*) die "qa-policy: invalid QA_POLICY_LTO_FLAVOR=${QA_POLICY_LTO_FLAVOR}" ;;
	esac

	for var in \
		QA_POLICY_SKIP_PATHS \
		QA_POLICY_LINKER_ALLOW \
		QA_POLICY_RPATH_ALLOW \
		QA_POLICY_ELF_ALLOW_TEXTREL \
		QA_POLICY_ELF_ALLOW_EXECSTACK \
		QA_POLICY_ELF_ALLOW_MISSING_SONAME \
		QA_POLICY_ELF_ALLOW_INTERP; do
		_qa-policy-validate-pattern-list "${var}"
	done

	[[ ${QA_POLICY_RPATH_MODE} != off || ${QA_POLICY_RPATH_CLEAN} == 0 ]] || \
		die "qa-policy: QA_POLICY_RPATH_CLEAN=1 requires QA_POLICY_RPATH_MODE!=off"
	[[ ${QA_POLICY_ELF_MODE} != off || ${QA_POLICY_ELF_REQUIRE_NOW} == 0 ]] || \
		die "qa-policy: QA_POLICY_ELF_REQUIRE_NOW=1 requires QA_POLICY_ELF_MODE!=off"
	[[ ${QA_POLICY_ELF_MODE} != off || ${QA_POLICY_ELF_REQUIRE_RELRO} == 0 ]] || \
		die "qa-policy: QA_POLICY_ELF_REQUIRE_RELRO=1 requires QA_POLICY_ELF_MODE!=off"
	[[ ${QA_POLICY_ELF_MODE} != off || ${QA_POLICY_ELF_REQUIRE_PIE} == 0 ]] || \
		die "qa-policy: QA_POLICY_ELF_REQUIRE_PIE=1 requires QA_POLICY_ELF_MODE!=off"
}

_qa-policy-discover-installed-files() {
	local input file rel
	local -a inputs=()
	local -a found=()

	if [[ ${#} -eq 0 ]]; then
		inputs=( "${ED}" )
	else
		inputs=( "$@" )
	fi

	for input in "${inputs[@]}"; do
		[[ -e ${input} ]] || die "qa-policy: missing path ${input}"
	done

	for input in "${inputs[@]}"; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -print0)
			QA_DISCOVER_ALL_FILES+=( "${found[@]}" )
		elif [[ -f ${input} ]]; then
			QA_DISCOVER_ALL_FILES+=( "${input}" )
		fi
	done

	local -a filtered=()
	for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
		rel=$(_qa-policy-relpath "${file}")
		_qa-policy-path-skipped "${rel}" && continue
		filtered+=( "${file}" )

		case ${file} in
			*.a) QA_DISCOVER_ARCHIVES+=( "${file}" ) ;;
			*.pc) QA_DISCOVER_PKGCONFIG+=( "${file}" ) ;;
			*.so)
				_bu-is-ldscript "${file}" && QA_DISCOVER_LDSCRIPTS+=( "${file}" )
				;;
		esac

		_elfqa-is-elf "${file}" && QA_DISCOVER_ELF_FILES+=( "${file}" )
	done

	QA_DISCOVER_ALL_FILES=( "${filtered[@]}" )
}

_qa-policy-run-configure() {
	qa-linker-configure
	qa-lto-configure
}

_qa-policy-maybe-finalize-early() {
	if [[ ${QA_POLICY_FAIL_FAST} == 1 ]] && qa-report-has-failures; then
		_qa-policy-finalize
	fi
}

_qa-policy-run-sanitize() {
	_qa-report-set-stage sanitize

	if [[ ${QA_POLICY_LTO_MODE} != off ]]; then
		qa-lto-sanitize
	fi

	if [[ ${QA_POLICY_ARCHIVE_MODE} != off ]]; then
		qa-archive-sanitize
	fi

	if [[ ${QA_POLICY_RPATH_MODE} != off ]]; then
		qa-rpath-sanitize
	fi
}

_qa-policy-run-assert() {
	_qa-report-set-stage assert

	if [[ ${QA_POLICY_ARCHIVE_MODE} != off ]]; then
		qa-archive-assert
		_qa-policy-maybe-finalize-early
	fi

	if [[ ${QA_POLICY_RPATH_MODE} != off ]]; then
		qa-rpath-assert
		_qa-policy-maybe-finalize-early
	fi

	if [[ ${QA_POLICY_PKGCONFIG_MODE} != off ]]; then
		qa-pkgconfig-assert
		_qa-policy-maybe-finalize-early
	fi

	if [[ ${QA_POLICY_ELF_MODE} != off ]]; then
		qa-elf-assert
		_qa-policy-maybe-finalize-early
	fi

	if [[ ${QA_POLICY_LINKER_MODE} != off ]]; then
		qa-linker-assert
		_qa-policy-maybe-finalize-early
	fi
}

_qa-policy-finalize() {
	qa-report-print
	if qa-report-has-failures; then
		die "qa-policy-install: policy failures detected"
	fi
}

_qa-policy-print-header() {
	:
}

_qa-policy-print-footer() {
	:
}

qa-policy-configure() {
	[[ ${QA_POLICY_ENABLE:-1} == 1 ]] || return 0

	_qa-policy-init
	_qa-policy-validate-config
	_qa-policy-run-configure
}

qa-policy-compile() {
	[[ ${QA_POLICY_ENABLE:-1} == 1 ]] || return 0
	return 0
}

qa-policy-install() {
	[[ ${QA_POLICY_ENABLE:-1} == 1 ]] || return 0

	_qa-policy-init
	_qa-policy-validate-config
	_qa-policy-discover-installed-files "$@"

	if [[ ${QA_POLICY_SANITIZE} == 1 ]]; then
		_qa-policy-run-sanitize
	fi

	if [[ ${QA_POLICY_ASSERT} == 1 ]]; then
		_qa-policy-run-assert
	fi

	_qa-policy-finalize
}

fi

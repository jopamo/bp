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

if [[ -z ${_QA_POLICY_ECLASS:-} ]] ; then
_QA_POLICY_ECLASS=1

inherit qa-report qa-linker qa-lto qa-archive qa-shebang qa-perms qa-symlink qa-rpath qa-pkgconfig qa-elf

BDEPEND+=" app-dev/patchelf"

_qa-policy-relpath() {
	local file=$1
	local root
	local -a roots=()

	if [[ -n ${ED-} ]]; then
		roots+=( "${ED%/}" )
	fi

	if declare -p QA_DISCOVER_ROOTS >/dev/null 2>&1; then
		roots+=( "${QA_DISCOVER_ROOTS[@]}" )
	fi

	for root in "${roots[@]}"; do
		if [[ -n ${root} && ${file} == "${root}"/* ]]; then
			printf '%s\n' "${file#${root}}"
			return 0
		fi
	done

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

_qa-policy-validate-soft-mode() {
	case ${1} in
		off|report|warn) ;;
		*) die "qa-policy: invalid soft mode ${1}" ;;
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
	: "${QA_POLICY_SHOW_CLEAN:=0}"
	: "${QA_POLICY_SUMMARY:=full}"
	: "${QA_POLICY_SANITIZE:=1}"
	: "${QA_POLICY_ASSERT:=1}"
	: "${QA_POLICY_SKIP_PATHS:=}"

	case ${QA_POLICY_PROFILE} in
		base)
			: "${QA_POLICY_FAIL_FAST:=1}"
			: "${QA_POLICY_LINKER_MODE:=fail}"
			: "${QA_POLICY_LTO_MODE:=fail}"
			: "${QA_POLICY_ARCHIVE_MODE:=fail}"
			: "${QA_POLICY_LIBTOOL_MODE:=fail}"
			: "${QA_POLICY_SHEBANG_MODE:=fail}"
			: "${QA_POLICY_PERMS_MODE:=fail}"
			: "${QA_POLICY_SYMLINK_MODE:=fail}"
			: "${QA_POLICY_RPATH_MODE:=fail}"
			: "${QA_POLICY_PKGCONFIG_MODE:=warn}"
			: "${QA_POLICY_ELF_MODE:=report}"
			;;
		strict)
			: "${QA_POLICY_FAIL_FAST:=0}"
			: "${QA_POLICY_LINKER_MODE:=fail}"
			: "${QA_POLICY_LTO_MODE:=fail}"
			: "${QA_POLICY_ARCHIVE_MODE:=fail}"
			: "${QA_POLICY_LIBTOOL_MODE:=fail}"
			: "${QA_POLICY_SHEBANG_MODE:=fail}"
			: "${QA_POLICY_PERMS_MODE:=fail}"
			: "${QA_POLICY_SYMLINK_MODE:=fail}"
			: "${QA_POLICY_RPATH_MODE:=fail}"
			: "${QA_POLICY_PKGCONFIG_MODE:=fail}"
			: "${QA_POLICY_ELF_MODE:=fail}"
			;;
		dev)
			: "${QA_POLICY_FAIL_FAST:=0}"
			: "${QA_POLICY_LINKER_MODE:=warn}"
			: "${QA_POLICY_LTO_MODE:=warn}"
			: "${QA_POLICY_ARCHIVE_MODE:=warn}"
			: "${QA_POLICY_LIBTOOL_MODE:=warn}"
			: "${QA_POLICY_SHEBANG_MODE:=warn}"
			: "${QA_POLICY_PERMS_MODE:=warn}"
			: "${QA_POLICY_SYMLINK_MODE:=warn}"
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
	: "${QA_POLICY_ARCHIVE_EXPECT_EMPTY:=}"
	: "${QA_POLICY_ARCHIVE_REQUIRE_INDEX:=1}"
	: "${QA_POLICY_ARCHIVE_CHECK_LDSCRIPTS:=1}"
	: "${QA_POLICY_SHEBANG_SANITIZE:=0}"
	: "${QA_POLICY_PERMS_SANITIZE:=1}"
	: "${QA_POLICY_PERMS_CHECK_WORLD_WRITABLE:=0}"
	: "${QA_POLICY_PERMS_SUID_SGID_ALLOW:=}"
	: "${QA_POLICY_LA_SANITIZE:=1}"
	: "${QA_POLICY_LA_ALLOW:=}"
	: "${QA_POLICY_SYMLINK_SANITIZE:=0}"
	: "${QA_POLICY_RPATH_ALLOW:=}"
	: "${QA_POLICY_RPATH_CLEAN:=1}"
	: "${QA_POLICY_RPATH_ALLOW_EMPTY:=0}"
	: "${QA_POLICY_PKGCONFIG_ALLOW_HOST_PATHS:=0}"
	: "${QA_POLICY_PKGCONFIG_ALLOW_MISSING_REQUIRES:=0}"
	: "${QA_POLICY_PKGCONFIG_ALLOW_NONEXISTENT_LIBDIRS:=0}"
	: "${QA_POLICY_PKGCONFIG_REQUIRE_VERSION:=0}"
	: "${QA_POLICY_PKGCONFIG_REQUIRE_IMAGE_REQUIRES:=0}"
	: "${QA_POLICY_ELF_ALLOW_TEXTREL:=}"
	: "${QA_POLICY_ELF_ALLOW_EXECSTACK:=}"
	: "${QA_POLICY_ELF_ALLOW_MISSING_SONAME:=}"
	: "${QA_POLICY_ELF_ALLOW_INTERP:=}"
	: "${QA_POLICY_ELF_HARDENING_MODE:=report}"
	: "${QA_POLICY_ELF_CHECK_UNUSED_DT_NEEDED:=0}"
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
	declare -ga QA_DISCOVER_SYMLINKS=()
	declare -ga QA_DISCOVER_ROOTS=()
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
		QA_POLICY_SHEBANG_SANITIZE \
		QA_POLICY_PERMS_SANITIZE \
		QA_POLICY_PERMS_CHECK_WORLD_WRITABLE \
		QA_POLICY_LA_SANITIZE \
		QA_POLICY_SYMLINK_SANITIZE \
		QA_POLICY_RPATH_CLEAN \
		QA_POLICY_RPATH_ALLOW_EMPTY \
		QA_POLICY_PKGCONFIG_ALLOW_HOST_PATHS \
		QA_POLICY_PKGCONFIG_ALLOW_MISSING_REQUIRES \
		QA_POLICY_PKGCONFIG_ALLOW_NONEXISTENT_LIBDIRS \
		QA_POLICY_PKGCONFIG_REQUIRE_VERSION \
		QA_POLICY_PKGCONFIG_REQUIRE_IMAGE_REQUIRES \
		QA_POLICY_ELF_CHECK_UNUSED_DT_NEEDED \
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
		QA_POLICY_LIBTOOL_MODE \
		QA_POLICY_SHEBANG_MODE \
		QA_POLICY_PERMS_MODE \
		QA_POLICY_SYMLINK_MODE \
		QA_POLICY_RPATH_MODE \
		QA_POLICY_PKGCONFIG_MODE \
		QA_POLICY_ELF_MODE; do
		_qa-policy-validate-mode "${!var}"
	done

	_qa-policy-validate-soft-mode "${QA_POLICY_ELF_HARDENING_MODE}"

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
		QA_POLICY_ARCHIVE_EXPECT_EMPTY \
		QA_POLICY_PERMS_SUID_SGID_ALLOW \
		QA_POLICY_LA_ALLOW \
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
		[[ -n ${ED-} ]] || die "qa-policy-install requires a path or ED"
		inputs=( "${ED}" )
	else
		inputs=( "$@" )
	fi

	for input in "${inputs[@]}"; do
		[[ -e ${input} || -L ${input} ]] || die "qa-policy: missing path ${input}"
	done

	for input in "${inputs[@]}"; do
		if [[ -d ${input} ]]; then
			QA_DISCOVER_ROOTS+=( "${input%/}" )
			mapfile -d '' -t found < <(find -H "${input}" \( -type f -o -type l \) -print0)
			QA_DISCOVER_ALL_FILES+=( "${found[@]}" )
		elif [[ -L ${input} || -f ${input} ]]; then
			QA_DISCOVER_ALL_FILES+=( "${input}" )
		fi
	done

	local -a filtered=()
	for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
		rel=$(_qa-policy-relpath "${file}")
		_qa-policy-path-skipped "${rel}" && continue

		if [[ -L ${file} ]]; then
			QA_DISCOVER_SYMLINKS+=( "${file}" )
			continue
		fi

		filtered+=( "${file}" )

		case ${file} in
			*.a)
				# Some packages install standalone ELF objects with a .a suffix
				# (for example glibc's libmcheck.a). Only feed real ar archives to
				# ranlib/ar based sanitizers.
				_bu-is-archive "${file}" && QA_DISCOVER_ARCHIVES+=( "${file}" )
				;;
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

	qa-report-domain-begin libtool
	local file rel re dep_line dep_value
	local -a kept_files=()
	local -a kept_links=()
	local -i files_scanned=0 la_files_seen=0 files_removed=0 files_kept=0
	local -i dependency_libs_cleaned=0 allowlisted=0

	for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
		(( files_scanned += 1 ))

		if [[ ${file} == *.la ]]; then
			(( la_files_seen += 1 ))
			rel=$(_qa-policy-relpath "${file}")
			allowlisted=0

			if [[ ${QA_POLICY_LA_SANITIZE} == 1 ]]; then
				for re in ${QA_POLICY_LA_ALLOW}; do
					if [[ ${rel} =~ ${re} ]]; then
						allowlisted=1
						qa-report-note libtool kept-la "${rel}" "kept libtool archive due to allowlist"
						break
					fi
				done

				if [[ ${allowlisted} == 0 ]]; then
					rm -f -- "${file}" || die "qa-policy: failed to remove libtool archive ${file}"
					(( files_removed += 1 ))
					qa-report-note libtool removed-la "${rel}" "removed libtool archive from install image"
					continue
				fi
			fi

			dep_line=$(sed -n 's/^dependency_libs=//p' "${file}" | head -n 1)
			if [[ -n ${dep_line} ]]; then
				dep_value=${dep_line#\"}
				dep_value=${dep_value%\"}
				dep_value=${dep_value#\'}
				dep_value=${dep_value%\'}
				if [[ -n ${dep_value} ]]; then
					sed -i -e "s|^dependency_libs=.*$|dependency_libs=''|" "${file}" || \
						die "qa-policy: failed to clean dependency_libs for ${file}"
					(( dependency_libs_cleaned += 1 ))
					qa-report-note libtool cleaned-dependency-libs "${rel}" "reset non-empty dependency_libs"
				fi
			fi

			(( files_kept += 1 ))
		fi

		kept_files+=( "${file}" )
	done

	QA_DISCOVER_ALL_FILES=( "${kept_files[@]}" )

	for file in "${QA_DISCOVER_SYMLINKS[@]}"; do
		(( files_scanned += 1 ))
		[[ ${file} == *.la ]] || {
			kept_links+=( "${file}" )
			continue
		}

		(( la_files_seen += 1 ))
		rel=$(_qa-policy-relpath "${file}")
		allowlisted=0

		if [[ ${QA_POLICY_LA_SANITIZE} == 1 ]]; then
			for re in ${QA_POLICY_LA_ALLOW}; do
				if [[ ${rel} =~ ${re} ]]; then
					allowlisted=1
					qa-report-note libtool kept-la "${rel}" "kept libtool archive due to allowlist"
					break
				fi
			done

			if [[ ${allowlisted} == 0 ]]; then
				rm -f -- "${file}" || die "qa-policy: failed to remove libtool archive symlink ${file}"
				(( files_removed += 1 ))
				qa-report-note libtool removed-la "${rel}" "removed libtool archive from install image"
				continue
			fi
		fi

		(( files_kept += 1 ))
		kept_links+=( "${file}" )
	done

	QA_DISCOVER_SYMLINKS=( "${kept_links[@]}" )

	qa-report-domain-stat libtool files_scanned "${files_scanned}"
	qa-report-domain-stat libtool la_files_seen "${la_files_seen}"
	qa-report-domain-stat libtool files_removed "${files_removed}"
	qa-report-domain-stat libtool files_kept "${files_kept}"
	qa-report-domain-stat libtool dependency_libs_cleaned "${dependency_libs_cleaned}"

	if [[ ${QA_POLICY_LTO_MODE} != off ]]; then
		qa-lto-sanitize
	fi

	if [[ ${QA_POLICY_ARCHIVE_MODE} != off ]]; then
		qa-archive-sanitize
	fi

	if [[ ${QA_POLICY_SHEBANG_MODE} != off ]]; then
		qa-shebang-sanitize
	fi

	if [[ ${QA_POLICY_PERMS_MODE} != off ]]; then
		qa-perms-sanitize
	fi

	if [[ ${QA_POLICY_SYMLINK_MODE} != off ]]; then
		qa-symlink-sanitize
	fi

	if [[ ${QA_POLICY_RPATH_MODE} != off ]]; then
		qa-rpath-sanitize
	fi
}

_qa-policy-libtool-check-file() {
	local la_file=$1
	local rel=$2
	local mode=${QA_POLICY_LIBTOOL_MODE}
	local needle dep_line dep_value

	for needle in "${D-}" "${ED-}" "${WORKDIR-}" "${T-}"; do
		[[ -n ${needle} ]] || continue
		if grep -Fqs -- "${needle}" "${la_file}"; then
			_qa-report-record-mode libtool "${mode}" build-path-leak "${rel}" "libtool archive contains build path: ${needle}"
			break
		fi
	done

	dep_line=$(sed -n 's/^dependency_libs=//p' "${la_file}" | head -n 1)
	if [[ -n ${dep_line} ]]; then
		dep_value=${dep_line#\"}
		dep_value=${dep_value%\"}
		dep_value=${dep_value#\'}
		dep_value=${dep_value%\'}
		if [[ -n ${dep_value} ]]; then
			_qa-report-record-mode libtool "${mode}" dependency-libs "${rel}" "unexpected non-empty dependency_libs: ${dep_line}"
		fi
	fi
}

_qa-policy-run-assert() {
	_qa-report-set-stage assert

	if [[ ${QA_POLICY_ARCHIVE_MODE} != off ]]; then
		qa-archive-assert
		_qa-policy-maybe-finalize-early
	fi

	if [[ ${QA_POLICY_LIBTOOL_MODE} != off ]]; then
		qa-report-domain-begin libtool
		local file rel
		local -i files_scanned=0
		for file in "${QA_DISCOVER_ALL_FILES[@]}"; do
			[[ ${file} == *.la ]] || continue
			(( files_scanned += 1 ))
			rel=$(_qa-policy-relpath "${file}")
			_qa-policy-libtool-check-file "${file}" "${rel}"
		done
		qa-report-domain-stat libtool files_scanned "${files_scanned}"
		_qa-policy-maybe-finalize-early
	fi

	if [[ ${QA_POLICY_SHEBANG_MODE} != off ]]; then
		qa-shebang-assert
		_qa-policy-maybe-finalize-early
	fi

	if [[ ${QA_POLICY_PERMS_MODE} != off ]]; then
		qa-perms-assert
		_qa-policy-maybe-finalize-early
	fi

	if [[ ${QA_POLICY_SYMLINK_MODE} != off ]]; then
		qa-symlink-assert
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

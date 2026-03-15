# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-pkgconfig.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal pkg-config validation helpers for qa-policy

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_QA_PKGCONFIG_ECLASS:-} ]] ; then
_QA_PKGCONFIG_ECLASS=1

inherit qa-report pkgconfig-sanity

_qa-pkgconfig-trim() {
	printf '%s\n' "$1" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

_qa-pkgconfig-line() {
	local file=$1
	local key=$2

	sed -n "s/^${key}:[[:space:]]*//p" "${file}" | head -n1
}

_qa-pkgconfig-load-vars() {
	local file=$1
	local rel=$2
	local assoc_name=$3
	local line
	local -n vars_ref=${assoc_name}

	vars_ref=()
	vars_ref[pcfiledir]=$(dirname "${rel}")

	while IFS= read -r line || [[ -n ${line} ]]; do
		[[ ${line} =~ ^([A-Za-z][A-Za-z0-9_]*)=(.*)$ ]] || continue
		vars_ref[${BASH_REMATCH[1]}]=${BASH_REMATCH[2]}
	done < "${file}"
}

_qa-pkgconfig-expand() {
	local value=$1
	local assoc_name=$2
	local expanded=${value}
	local previous key
	local -n vars_ref=${assoc_name}
	local -i rounds=0

	while (( rounds < 8 )); do
		previous=${expanded}
		for key in "${!vars_ref[@]}"; do
			expanded=${expanded//\$\{${key}\}/${vars_ref[${key}]}}
		done
		[[ ${expanded} == "${previous}" ]] && break
		(( rounds += 1 ))
	done

	printf '%s\n' "${expanded}"
}

_qa-pkgconfig-path-exists() {
	local path=$1
	local root

	if [[ -n ${ED-} ]] && [[ -e ${ED%/}${path} ]]; then
		return 0
	fi

	if declare -p QA_DISCOVER_ROOTS >/dev/null 2>&1; then
		for root in "${QA_DISCOVER_ROOTS[@]}"; do
			[[ -e ${root%/}${path} ]] && return 0
		done
	fi

	[[ -e ${path} ]] && return 0
	return 1
}

_qa-pkgconfig-host-path-in-line() {
	local value=$1

	grep -Eq '(^|[[:space:]])-L/usr/lib(64)?([[:space:]]|$)|(^|[[:space:]])-I/usr/include([[:space:]]|$)' <<< "${value}"
}

_qa-pkgconfig-check-prefix() {
	local file=$1
	local rel=$2
	local assoc_name=$3
	local key value expanded
	local -n vars_ref=${assoc_name}

	for key in prefix libdir includedir; do
		value=${vars_ref[${key}]:-}
		[[ -n ${value} ]] || continue

		expanded=$(_qa-pkgconfig-expand "${value}" "${assoc_name}")
		if [[ -z ${expanded} ]] || [[ ${expanded} == *'${'* ]]; then
			_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" invalid-prefix "${rel}" "${key} did not resolve cleanly"
			continue
		fi

		if [[ ${expanded} != /* ]]; then
			_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" invalid-prefix "${rel}" "${key} must resolve to an absolute path"
			continue
		fi

		if grep -Eq '/var/tmp/|/tmp/portage/' <<< "${expanded}"; then
			_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" build-path "${rel}" "${key} contains a build path"
		fi
	done
}

_qa-pkgconfig-check-libs() {
	local file=$1
	local rel=$2
	local assoc_name=$3
	local raw expanded token path

	raw=$(_qa-pkgconfig-line "${file}" Libs)
	expanded=$(_qa-pkgconfig-expand "${raw}" "${assoc_name}")

	if [[ ${QA_POLICY_PKGCONFIG_ALLOW_HOST_PATHS} == 0 ]] && _qa-pkgconfig-host-path-in-line "${raw}"; then
		_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" host-path "${rel}" "hardcoded host path in Libs"
	fi

	for token in ${expanded}; do
		case ${token} in
			-L)
				_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" broken-libs "${rel}" "Libs contains bare -L"
				;;
			-l)
				_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" broken-libs "${rel}" "Libs contains bare -l"
				;;
			-L?*)
				path=${token#-L}
				if [[ ${QA_POLICY_PKGCONFIG_ALLOW_NONEXISTENT_LIBDIRS} == 0 ]] && [[ ${path} == /* ]] && ! _qa-pkgconfig-path-exists "${path}"; then
					_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" missing-path "${rel}" "Libs references missing directory ${path}"
				fi
				;;
		esac
	done
}

_qa-pkgconfig-check-cflags() {
	local file=$1
	local rel=$2
	local assoc_name=$3
	local raw expanded token path

	raw=$(_qa-pkgconfig-line "${file}" Cflags)
	expanded=$(_qa-pkgconfig-expand "${raw}" "${assoc_name}")

	if [[ ${QA_POLICY_PKGCONFIG_ALLOW_HOST_PATHS} == 0 ]] && _qa-pkgconfig-host-path-in-line "${raw}"; then
		_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" host-path "${rel}" "hardcoded host path in Cflags"
	fi

	for token in ${expanded}; do
		case ${token} in
			-I)
				_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" broken-cflags "${rel}" "Cflags contains bare -I"
				;;
			-I?*)
				path=${token#-I}
				if [[ ${path} == /* ]] && ! _qa-pkgconfig-path-exists "${path}"; then
					_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" missing-path "${rel}" "Cflags references missing directory ${path}"
				fi
				;;
		esac
	done
}

_qa-pkgconfig-check-duplicates() {
	local rel=$1
	local label=$2
	local expanded=$3
	local token
	local -A seen=()
	local -A reported=()

	for token in ${expanded}; do
		case ${token} in
			-I?*|-L?*|-l?*)
				if [[ -n ${seen[${token}]:-} ]] && [[ -z ${reported[${token}]:-} ]]; then
					reported[${token}]=1
					_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" duplicate-flag "${rel}" \
						"${label} contains duplicate flag ${token}"
				else
					seen[${token}]=1
				fi
				;;
		esac
	done
}

_qa-pkgconfig-check-version() {
	local file=$1
	local rel=$2
	local version

	[[ ${QA_POLICY_PKGCONFIG_REQUIRE_VERSION} == 1 ]] || return 0

	version=$(_qa-pkgconfig-trim "$(_qa-pkgconfig-line "${file}" Version)")
	[[ -n ${version} ]] || \
		_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" missing-version "${rel}" "missing Version field"
}

_qa-pkgconfig-check-requires-line() {
	local rel=$1
	local label=$2
	local value=$3
	local chunk trimmed
	local -a search_dirs=()

	[[ -n ${value} ]] || return 0

	IFS=',' read -r -a chunks <<< "${value}"
	for chunk in "${chunks[@]}"; do
		trimmed=$(_qa-pkgconfig-trim "${chunk}")
		if [[ -z ${trimmed} ]]; then
			_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" malformed-requires "${rel}" "${label} contains an empty requirement token"
			continue
		fi

		if [[ ! ${trimmed} =~ ^[A-Za-z0-9_.+-]+([[:space:]]*(=|>=|<=|<|>)[[:space:]]*[A-Za-z0-9_.:+-]+)?$ ]]; then
			_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" malformed-requires "${rel}" "${label} contains malformed token ${trimmed}"
			continue
		fi

		[[ ${QA_POLICY_PKGCONFIG_ALLOW_MISSING_REQUIRES} == 0 ]] || continue
		command -v pkg-config >/dev/null || continue

		search_dirs=()
		[[ -d ${ED%/}/usr/lib/pkgconfig ]] && search_dirs+=( "${ED%/}/usr/lib/pkgconfig" )
		[[ -d ${ED%/}/usr/lib64/pkgconfig ]] && search_dirs+=( "${ED%/}/usr/lib64/pkgconfig" )
		[[ -d ${ED%/}/usr/share/pkgconfig ]] && search_dirs+=( "${ED%/}/usr/share/pkgconfig" )

		if PKG_CONFIG_LIBDIR=$(IFS=:; printf '%s' "${search_dirs[*]}") \
			PKG_CONFIG_PATH=$(IFS=:; printf '%s' "${search_dirs[*]}") \
			pkg-config --exists "${trimmed}"; then
			continue
		fi

		if [[ ${QA_POLICY_PKGCONFIG_REQUIRE_IMAGE_REQUIRES} == 0 ]] && pkg-config --exists "${trimmed}"; then
			continue
		fi

		_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" missing-requires "${rel}" "${label} requirement not resolvable: ${trimmed}"
	done
}

qa-pkgconfig-list() {
	printf '%s\n' "${QA_DISCOVER_PKGCONFIG[@]}"
}

qa-pkgconfig-check-prefix() {
	_qa-pkgconfig-check-prefix "$@"
}

qa-pkgconfig-check-host-paths() {
	return 0
}

qa-pkgconfig-check-libs() {
	_qa-pkgconfig-check-libs "$@"
	local file=$1 assoc_name=$3
	_qa-pkgconfig-check-duplicates "$2" Libs "$(_qa-pkgconfig-expand "$(_qa-pkgconfig-line "${file}" Libs)" "${assoc_name}")"
}

qa-pkgconfig-check-cflags() {
	_qa-pkgconfig-check-cflags "$@"
	local file=$1 assoc_name=$3
	_qa-pkgconfig-check-duplicates "$2" Cflags "$(_qa-pkgconfig-expand "$(_qa-pkgconfig-line "${file}" Cflags)" "${assoc_name}")"
}

qa-pkgconfig-check-requires() {
	local file=$1
	local rel=$2
	local assoc_name=$3
	local requires requires_private

	requires=$(_qa-pkgconfig-expand "$(_qa-pkgconfig-line "${file}" Requires)" "${assoc_name}")
	requires_private=$(_qa-pkgconfig-expand "$(_qa-pkgconfig-line "${file}" Requires.private)" "${assoc_name}")

	_qa-pkgconfig-check-requires-line "${rel}" Requires "${requires}"
	_qa-pkgconfig-check-requires-line "${rel}" Requires.private "${requires_private}"
}

qa-pkgconfig-check-version() {
	_qa-pkgconfig-check-version "$@"
}

qa-pkgconfig-assert() {
	qa-report-domain-begin pkgconfig

	local -a files=( "${QA_DISCOVER_PKGCONFIG[@]}" )
	local file rel
	local -A vars=()

	for file in "${files[@]}"; do
		rel=$(_qa-policy-relpath "${file}")

		if _pc-has-build-leak "${file}"; then
			_qa-report-record-mode pkgconfig "${QA_POLICY_PKGCONFIG_MODE}" build-path "${rel}" "build path leaked into pkg-config metadata"
		fi

		_qa-pkgconfig-load-vars "${file}" "${rel}" vars
		qa-pkgconfig-check-prefix "${file}" "${rel}" vars
		qa-pkgconfig-check-host-paths "${file}" "${rel}"
		qa-pkgconfig-check-libs "${file}" "${rel}" vars
		qa-pkgconfig-check-cflags "${file}" "${rel}" vars
		qa-pkgconfig-check-requires "${file}" "${rel}" vars
		qa-pkgconfig-check-version "${file}" "${rel}" vars
	done

	qa-report-domain-stat pkgconfig scanned "${#files[@]}"
}

fi

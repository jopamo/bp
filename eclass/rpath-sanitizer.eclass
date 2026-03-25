# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rpath-sanitizer.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: RPATH and RUNPATH policy sanitizer for installed ELFs
# @DESCRIPTION:
# Supports no-rpath, origin-only, and regex whitelist policies


if [[ -z ${_RPATH_SANITIZER_ECLASS:-} ]] ; then
_RPATH_SANITIZER_ECLASS=1

inherit toolchain-funcs

: "${RPATH_POLICY:=none}"
: "${RPATH_ORIGIN_ALLOW:=\$ORIGIN \$ORIGIN/.. \$ORIGIN/../lib}"
: "${RPATH_ORIGIN_DEFAULT:=\$ORIGIN}"
: "${RPATH_WHITELIST:=}"
: "${RPATH_ALLOW:=}"
: "${RPATH_STRICT:=1}"
: "${RPATH_SCRUB_LA:=1}"

_rpath-rule-allowed() {
	local rule=$1
	local rel=$2
	local token rule_part re

	for token in ${RPATH_ALLOW}; do
		if [[ ${token} == *:* ]]; then
			rule_part=${token%%:*}
			re=${token#*:}
			[[ ${rule} == "${rule_part}" && ${rel} =~ ${re} ]] && return 0
		else
			[[ ${rel} =~ ${token} ]] && return 0
		fi
	done

	return 1
}

_rpath-find-files() {
	local -n out_ref=$1
	shift || true

	local input
	local -a found=()

	out_ref=()

	if [[ ${#} -eq 0 ]]; then
		[[ -n ${ED-} ]] || die "rpath: no scan paths provided and ED is unset"
		set -- "${ED}"
	fi

	for input in "$@" ; do
		[[ -e ${input} ]] || die "rpath: missing path ${input}"
	done

	for input in "$@" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -print0)
			out_ref+=( "${found[@]}" )
		elif [[ -f ${input} ]]; then
			out_ref+=( "${input}" )
		fi
	done
}

_rpath-is-elf() {
	local file=$1
	local readelf_cmd
	readelf_cmd=$(tc-getREADELF)
	"${readelf_cmd}" -h "${file}" >/dev/null 2>&1
}

_rpath-get() {
	local file=$1
	local readelf_cmd dyn got
	readelf_cmd=$(tc-getREADELF)
	dyn=$("${readelf_cmd}" -d "${file}" 2>/dev/null || true)
	got=$(echo "${dyn}" | sed -n 's/.*(RPATH).*\[\(.*\)\].*/\1/p' | head -n1)
	[[ -n ${got} ]] || got=$(echo "${dyn}" | sed -n 's/.*(RUNPATH).*\[\(.*\)\].*/\1/p' | head -n1)
	echo "${got}"
}

_rpath-split() {
	local value=$1
	local -n out_ref=$2

	out_ref=()
	[[ -n ${value} ]] || return 0

	local IFS=':'
	read -r -a out_ref <<< "${value}"
}

_rpath-join() {
	local -n in_ref=$1
	local IFS=':'
	printf '%s\n' "${in_ref[*]}"
}

_rpath-entry-allowed() {
	local entry=$1
	local token

	case ${RPATH_POLICY} in
		none)
			return 1
			;;
		origin)
			for token in ${RPATH_ORIGIN_ALLOW}; do
				[[ ${entry} == "${token}" ]] && return 0
			done
			return 1
			;;
		whitelist)
			if [[ ${entry} == \$ORIGIN* ]]; then
				for token in ${RPATH_ORIGIN_ALLOW}; do
					[[ ${entry} == "${token}" ]] && return 0
				done
			fi
			for token in ${RPATH_WHITELIST}; do
				[[ ${entry} =~ ${token} ]] && return 0
			done
			return 1
			;;
		*)
			die "rpath: invalid RPATH_POLICY=${RPATH_POLICY}"
			;;
	esac
}

_rpath-filter-allowed() {
	local value=$1
	local -n out_ref=$2
	local entry
	local -a entries=()

	out_ref=()
	_rpath-split "${value}" entries

	for entry in "${entries[@]}" ; do
		[[ -n ${entry} ]] || continue
		_rpath-entry-allowed "${entry}" || continue
		_rpath-has-build-leak "${entry}" && continue
		out_ref+=( "${entry}" )
	done
}

_rpath-is-allowed() {
	local rpath=$1
	local piece
	local -a _rpath_pieces=()

	[[ -z ${rpath} ]] && return 0

	IFS=':' read -r -a _rpath_pieces <<< "${rpath}"
	for piece in "${_rpath_pieces[@]}" ; do
		_rpath-entry-allowed "${piece}" || return 1
	done

	return 0
}

_rpath-relpath() {
	local file=$1
	local ed=${ED-}

	if [[ -n ${ed} && ${file} == "${ed}"* ]]; then
		printf '%s\n' "${file#${ed}}"
	else
		printf '%s\n' "${file}"
	fi
}

_rpath-has-build-leak() {
	local value=$1
	local workdir=${WORKDIR-}
	local srcdir=${S-}

	[[ ${value} == *"/var/tmp/"* ]] || [[ ${value} == *"/tmp/portage/"* ]] || [[ -n ${workdir} && ${value} == *"${workdir}"* ]] || [[ -n ${srcdir} && ${value} == *"${srcdir}"* ]]
}

# @FUNCTION: rpath-clean
# @USAGE: [path] [more]
# @DESCRIPTION:
# Rewrite or remove disallowed RPATH and RUNPATH values
rpath-clean() {
	local patchelf_cmd
	patchelf_cmd=$(type -P patchelf || true)
	[[ -n ${patchelf_cmd} ]] || die "rpath-clean: patchelf is required"

	local -a files=()
	local -a kept=()
	local new_value

	_rpath-find-files files "$@"
	[[ ${#files[@]} -gt 0 ]] || return

	local file rel old
	for file in "${files[@]}" ; do
		_rpath-is-elf "${file}" || continue
		old=$(_rpath-get "${file}")
		[[ -n ${old} ]] || continue
		rel=$(_rpath-relpath "${file}")

		if _rpath-is-allowed "${old}" && ! _rpath-has-build-leak "${old}"; then
			continue
		fi

		if _rpath-rule-allowed rpath "${rel}"; then
			einfo "rpath: allowlisted ${rel}"
			continue
		fi

		kept=()
		_rpath-filter-allowed "${old}" kept
		new_value=$(_rpath-join kept)
		if [[ -z ${new_value} && ${RPATH_POLICY} == origin && -n ${RPATH_ORIGIN_DEFAULT} ]]; then
			new_value=${RPATH_ORIGIN_DEFAULT}
		fi

		if [[ -n ${new_value} ]]; then
			"${patchelf_cmd}" --set-rpath "${new_value}" "${file}" || die "rpath: failed to rewrite ${rel}"
			einfo "rpath: rewrote ${rel} -> ${new_value}"
		else
			"${patchelf_cmd}" --remove-rpath "${file}" || die "rpath: failed to remove rpath from ${rel}"
			einfo "rpath: removed rpath from ${rel}"
		fi
	done

	if [[ ${RPATH_SCRUB_LA} == 1 ]]; then
		local la
		for la in "${files[@]}" ; do
			[[ ${la} == *.la ]] || continue
			if grep -Eq '/var/tmp/|/tmp/portage/' "${la}"; then
				sed -i -E 's#-Wl,-rpath,[^[:space:]]+##g' "${la}" || die "rpath: failed to scrub ${la}"
				sed -i -E 's#[[:space:]]+# #g' "${la}" || die "rpath: failed to normalize ${la}"
			fi
		done
	fi
}

# @FUNCTION: rpath-check
# @USAGE: [path] [more]
# @DESCRIPTION:
# Scan installed ELFs and return non-zero on remaining RPATH policy violations
rpath-check() {
	local -a files=()

	_rpath-find-files files "$@"
	[[ ${#files[@]} -gt 0 ]] || return 0

	local -i failures=0
	local file rel current
	for file in "${files[@]}" ; do
		_rpath-is-elf "${file}" || continue
		current=$(_rpath-get "${file}")
		[[ -n ${current} ]] || continue
		rel=$(_rpath-relpath "${file}")

		if _rpath-rule-allowed rpath "${rel}"; then
			continue
		fi

		if ! _rpath-is-allowed "${current}" || _rpath-has-build-leak "${current}"; then
			eerror "rpath: violation in ${rel}: ${current}"
			(( failures += 1 ))
		fi
	done

	[[ ${failures} -eq 0 ]]
}

# @FUNCTION: rpath-assert-clean
# @USAGE: [path] [more]
# @DESCRIPTION:
# Scan installed ELFs and fail on remaining RPATH policy violations
rpath-assert-clean() {
	if rpath-check "$@"; then
		return 0
	fi

	local -a files=()

	_rpath-find-files files "$@"
	local -i failures=0
	local file rel current
	for file in "${files[@]}" ; do
		_rpath-is-elf "${file}" || continue
		current=$(_rpath-get "${file}")
		[[ -n ${current} ]] || continue
		rel=$(_rpath-relpath "${file}")
		if _rpath-rule-allowed rpath "${rel}"; then
			continue
		fi
		if ! _rpath-is-allowed "${current}" || _rpath-has-build-leak "${current}"; then
			(( failures += 1 ))
		fi
	done

	if [[ ${failures} -gt 0 ]]; then
		if [[ ${RPATH_STRICT} == 1 ]]; then
			die "rpath-assert-clean: ${failures} violation(s)"
		fi
		ewarn "rpath-assert-clean: ${failures} violation(s)"
	fi
}

fi

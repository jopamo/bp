# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rpath-sanitizer.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: RPATH and RUNPATH policy sanitizer for installed ELFs
# @DESCRIPTION:
# Supports no-rpath, origin-only, and regex whitelist policies

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_RPATH_SANITIZER_ECLASS} ]] ; then
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
	local input
	local -a files=()
	local -a found=()

	if [[ ${#} -eq 0 ]]; then
		set -- "${ED}"
	fi

	for input in "$@" ; do
		[[ -e ${input} ]] || die "rpath: missing path ${input}"
	done

	for input in "$@" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} ]]; then
			files+=( "${input}" )
		fi
	done

	echo "${files[@]}"
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

_rpath-is-allowed() {
	local rpath=$1
	[[ -z ${rpath} ]] && return 0

	local piece
	IFS=':' read -r -a _rpath_pieces <<< "${rpath}"
	for piece in "${_rpath_pieces[@]}" ; do
		_rpath-entry-allowed "${piece}" || return 1
	done

	return 0
}

_rpath-has-build-leak() {
	local value=$1
	[[ ${value} == *"/var/tmp/"* ]] || [[ ${value} == *"/tmp/portage/"* ]] || [[ -n ${WORKDIR} && ${value} == *"${WORKDIR}"* ]] || [[ -n ${S} && ${value} == *"${S}"* ]]
}

# @FUNCTION: rpath-clean
# @USAGE: [path] [more]
# @DESCRIPTION:
# Rewrite or remove disallowed RPATH and RUNPATH values
rpath-clean() {
	local patchelf_cmd
	patchelf_cmd=$(type -P patchelf || true)
	[[ -n ${patchelf_cmd} ]] || die "rpath-clean: patchelf is required"

	local -a files=( $(_rpath-find-files "$@") )
	[[ ${#files[@]} -gt 0 ]] || return

	local file rel old
	for file in "${files[@]}" ; do
		_rpath-is-elf "${file}" || continue
		old=$(_rpath-get "${file}")
		[[ -n ${old} ]] || continue
		rel=${file#${ED}}

		if _rpath-is-allowed "${old}" && ! _rpath-has-build-leak "${old}"; then
			continue
		fi

		if _rpath-rule-allowed rpath "${rel}"; then
			einfo "rpath: allowlisted ${rel}"
			continue
		fi

		case ${RPATH_POLICY} in
			origin)
				"${patchelf_cmd}" --set-rpath "${RPATH_ORIGIN_DEFAULT}" "${file}" || die "rpath: failed to rewrite ${rel}"
				einfo "rpath: rewrote ${rel} -> ${RPATH_ORIGIN_DEFAULT}"
				;;
			none|whitelist)
				"${patchelf_cmd}" --remove-rpath "${file}" || die "rpath: failed to remove rpath from ${rel}"
				einfo "rpath: removed rpath from ${rel}"
				;;
		esac
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

# @FUNCTION: rpath-assert-clean
# @USAGE: [path] [more]
# @DESCRIPTION:
# Scan installed ELFs and fail on remaining RPATH policy violations
rpath-assert-clean() {
	local -a files=( $(_rpath-find-files "$@") )
	[[ ${#files[@]} -gt 0 ]] || return

	local -i failures=0
	local file rel current
	for file in "${files[@]}" ; do
		_rpath-is-elf "${file}" || continue
		current=$(_rpath-get "${file}")
		[[ -n ${current} ]] || continue
		rel=${file#${ED}}

		if _rpath-rule-allowed rpath "${rel}"; then
			continue
		fi

		if ! _rpath-is-allowed "${current}" || _rpath-has-build-leak "${current}"; then
			eerror "rpath: violation in ${rel}: ${current}"
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

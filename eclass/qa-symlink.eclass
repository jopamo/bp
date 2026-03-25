# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qa-symlink.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Internal symlink sanitize and assertion helpers for qa-policy


if [[ -z ${_QA_SYMLINK_ECLASS:-} ]] ; then
_QA_SYMLINK_ECLASS=1

inherit qa-report

_qa-symlink-root-for-link() {
	local link=$1
	local root best=

	for root in "${QA_DISCOVER_ROOTS[@]}"; do
		root=${root%/}
		[[ -n ${root} && ${link} == "${root}"/* ]] || continue

		if [[ -z ${best} || ${#root} -gt ${#best} ]]; then
			best=${root}
		fi
	done

	[[ -n ${best} ]] && printf '%s\n' "${best}"
}

_qa-symlink-is-prefix-absolute-target() {
	case ${1} in
		/proc/*|/sys/*|/dev/*|/run/*) return 1 ;;
		/*) return 0 ;;
		*) return 1 ;;
	esac
}

_qa-symlink-target-exists() {
	local link=$1
	local target=$2
	local root resolved

	if [[ ${target} == /* ]]; then
		if _qa-symlink-is-prefix-absolute-target "${target}"; then
			root=$(_qa-symlink-root-for-link "${link}")
			if [[ -n ${root} ]]; then
				resolved="${root%/}${target}"
			else
				resolved="${target}"
			fi
		else
			resolved="${target}"
		fi
	else
		resolved=$(dirname -- "${link}")/${target}
	fi

	[[ -e "${resolved}" ]]
}

_qa-symlink-rewrite-target-relative() {
	local link=$1
	local target=$2
	local rel dir

	rel=$(_qa-policy-relpath "${link}")
	dir=${rel%/*}
	[[ ${dir} == "${rel}" ]] && dir=/
	realpath -m --relative-to="${dir}" -- "${target}" || die "qa-symlink: failed computing relative target for ${link}"
}

qa-symlink-list() {
	printf '%s\n' "${QA_DISCOVER_SYMLINKS[@]}"
}

qa-symlink-sanitize() {
	qa-report-domain-begin symlink

	local link rel target new_target
	local -i links_scanned=0 links_rewritten=0 absolute_in_prefix=0 dead_symlinks=0

	for link in "${QA_DISCOVER_SYMLINKS[@]}"; do
		(( links_scanned += 1 ))
		target=$(readlink -- "${link}") || die "qa-symlink: failed reading ${link}"
		rel=$(_qa-policy-relpath "${link}")

		if ! _qa-symlink-target-exists "${link}" "${target}"; then
			(( dead_symlinks += 1 ))
		fi

		_qa-symlink-is-prefix-absolute-target "${target}" || continue
		(( absolute_in_prefix += 1 ))

		[[ ${QA_POLICY_SYMLINK_SANITIZE} == 1 ]] || continue
		new_target=$(_qa-symlink-rewrite-target-relative "${link}" "${target}")
		[[ ${new_target} == "${target}" ]] && continue

		ln -snf -- "${new_target}" "${link}" || die "qa-symlink: failed rewriting ${link}"
		(( links_rewritten += 1 ))
		qa-report-note symlink sanitized-relative "${rel}" "rewrote absolute in-prefix symlink target to ${new_target}"
	done

	qa-report-domain-stat symlink links_scanned "${links_scanned}"
	qa-report-domain-stat symlink dead_symlinks "${dead_symlinks}"
	qa-report-domain-stat symlink absolute_in_prefix "${absolute_in_prefix}"
	qa-report-domain-stat symlink links_rewritten "${links_rewritten}"
}

qa-symlink-assert() {
	qa-report-domain-begin symlink

	local link rel target
	local -i links_scanned=0

	for link in "${QA_DISCOVER_SYMLINKS[@]}"; do
		(( links_scanned += 1 ))
		target=$(readlink -- "${link}") || die "qa-symlink: failed reading ${link}"
		rel=$(_qa-policy-relpath "${link}")

		if ! _qa-symlink-target-exists "${link}" "${target}"; then
			_qa-report-record-mode symlink "${QA_POLICY_SYMLINK_MODE}" dead-symlink "${rel}" "symlink target does not exist: ${target}"
		fi

		if _qa-symlink-is-prefix-absolute-target "${target}"; then
			_qa-report-record-mode symlink "${QA_POLICY_SYMLINK_MODE}" absolute-in-prefix-symlink "${rel}" "symlink uses absolute in-prefix target: ${target}"
		fi
	done

	qa-report-domain-stat symlink links_scanned "${links_scanned}"
}

fi

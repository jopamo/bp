# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: user-info.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Read-only access to user and group information


if [[ -z ${_USER_INFO_ECLASS:-} ]]; then
_USER_INFO_ECLASS=1

# --------------------------------------------------------------------
# internal: basic getent wrapper (Linux) with ROOT fallback
# --------------------------------------------------------------------
egetent() {
	[[ $# -eq 2 ]] || die "usage: egetent <passwd|group> <key>"

	local db=$1 key=$2 root=${ROOT:-}
	[[ ${db} == passwd || ${db} == group ]] \
		|| die "unsupported database '${db}'"

	# If ROOT is /, ask nss + nscd; otherwise query the chroot's files.
	if [[ -z ${root} || ${root} == "/" ]]; then
		type -p nscd &>/dev/null && nscd -i "${db}" 2>/dev/null || true
		getent "${db}" "${key}"
	else
		local file="${root%/}/etc/${db}"
		[[ -r ${file} ]] || return 2

		if [[ ${key} =~ ^[[:digit:]]+$ ]]; then
			# numeric uid/gid lookup (3rd field for passwd, 3rd for group)
			awk -F: -v key="${key}" '
				$3 == key { print; found = 1 }
				END { exit(found ? 0 : 2) }
			' "${file}"
		else
			# name lookup
			awk -F: -v key="${key}" '
				$1 == key { print; found = 1 }
				END { exit(found ? 0 : 2) }
			' "${file}"
		fi
	fi
}

# --------------------------------------------------------------------
# tiny helpers built on egetent
# --------------------------------------------------------------------
egetusername()   { [[ $# -eq 1 ]] || die; egetent passwd "$1" | cut -d: -f1; }
egetgroupname()  { [[ $# -eq 1 ]] || die; egetent group  "$1" | cut -d: -f1; }
egethome()       { [[ $# -eq 1 ]] || die; egetent passwd "$1" | cut -d: -f6; }
egetshell()      { [[ $# -eq 1 ]] || die; egetent passwd "$1" | cut -d: -f7; }
egetcomment()    { [[ $# -eq 1 ]] || die; egetent passwd "$1" | cut -d: -f5; }

# returns primary group + sorted supplementary groups, comma-separated
egetgroups() {
	[[ $# -eq 1 ]] || die "usage: egetgroups <user>"
	local user=$1 root=${ROOT:-}

	if [[ -z ${root} || ${root} == "/" ]]; then
		local groups_raw
		groups_raw=$(id -G -n "${user}") || return

		local -a groups sorted
		read -r -a groups <<< "${groups_raw}"
		printf '%s' "${groups[0]}"
		if [[ ${#groups[@]} -gt 1 ]]; then
			mapfile -t sorted < <(printf '%s\n' "${groups[@]:1}" | LC_ALL=C sort)
			printf ',%s' "${sorted[@]}"
		fi
		echo
	else
		local passwd_entry pg pgname
		passwd_entry=$(egetent passwd "${user}") || return
		pg=$(cut -d: -f4 <<< "${passwd_entry}")
		pgname=$(egetent group "${pg}" | cut -d: -f1) || return

		local -a sg=()
		mapfile -t sg < <(
			awk -F: -v user="${user}" -v primary="${pgname}" '
				$1 != primary {
					members = split($4, names, /,/)
					for (i = 1; i <= members; ++i) {
						if (names[i] == user) {
							print $1
							break
						}
					}
				}
			' "${root%/}/etc/group" 2>/dev/null | LC_ALL=C sort
		)
		printf '%s' "${pgname}"
		[[ ${#sg[@]} -gt 0 ]] && printf ',%s' "${sg[@]}"
		echo
	fi
}

fi  # _USER_INFO_ECLASS

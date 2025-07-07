# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: user-info.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Read-only access to user and group information

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_USER_INFO_ECLASS} ]]; then
_USER_INFO_ECLASS=1

# --------------------------------------------------------------------
# internal: basic getent wrapper (Linux) with ROOT fallback
# --------------------------------------------------------------------
egetent() {
	[[ $# -eq 2 ]] || die "usage: egetent <passwd|group> <key>"

	local db=$1 key=$2
	[[ ${db} == passwd || ${db} == group ]] \
		|| die "unsupported database '${db}'"

	# If ROOT is /, ask nss + nscd; otherwise grep the chroot's files.
	if [[ -z ${ROOT} || ${ROOT} == "/" ]]; then
		type -p nscd &>/dev/null && nscd -i "${db}" 2>/dev/null || true
		getent "${db}" "${key}"
	else
		local file="${ROOT}/etc/${db}"
		if [[ ${key} =~ ^[[:digit:]]+$ ]]; then
			# numeric uid/gid lookup (3rd field for passwd, 3rd for group)
			grep -E "^([^:]*:){2}${key}:" "${file}"
		else
			# name lookup
			grep -E "^${key}:" "${file}"
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
	local user=$1

	if [[ -z ${ROOT} || ${ROOT} == "/" ]]; then
		local -a g; read -ra g < <(id -G -n "${user}")
		printf '%s' "${g[0]}"
		printf ',%s' "${g[@]:1}" | tr ' ' '\n' | sort | tr '\n' ','
		echo
	else
		local pg=$(egetent passwd "${user}" | cut -d: -f4)
		local pgname=$(egetent group "${pg}" | cut -d: -f1)
		local -a sg=( $(grep -E ":([^:]*,)?${user}(,[^:]*)?$" "${ROOT}/etc/group" |
		                cut -d: -f1 | grep -v "^${pgname}$" | sort) )
		printf '%s' "${pgname}"
		[[ ${#sg[@]} -gt 0 ]] && printf ',%s' "${sg[*]}"
		echo
	fi
}

fi  # _USER_INFO_ECLASS

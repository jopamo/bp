# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: user.eclass
# @SUPPORTED_EAPIS: 6 7 8
# @BLURB: user / group management helpers

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_USER_ECLASS} ]]; then
_USER_ECLASS=1

inherit user-info   # egetent & friends

# ---------------------------------------------------------------------------
# internal phase guard
# ---------------------------------------------------------------------------
_user_assert_pkg_phase() {
	case ${EBUILD_PHASE} in
		setup|preinst|postinst|prerm|postrm) ;;
		*)  die "'$1()' may only be called from pkg_{setup,{pre,post}{inst,rm}}" ;;
	esac
}

# ---------------------------------------------------------------------------
# find a suitable nologin shell
# ---------------------------------------------------------------------------
user_get_nologin() {
	local sh
	for sh in /sbin/nologin /usr/sbin/nologin /bin/false /usr/bin/false ; do
		[[ -x ${ROOT%/}${sh} ]] && { echo "${sh}"; return; }
	done
	die "cannot find nologin/false shell"
}

# ---------------------------------------------------------------------------
# add user
# ---------------------------------------------------------------------------
enewuser() {
	[[ ${EUID} -eq 0 ]] || { ewarn "need root to add users"; return 0; }
	_user_assert_pkg_phase ${FUNCNAME}

	local create_home=1 force_uid
	while [[ $1 == -* ]]; do
		case $1 in
			-F) force_uid=1 ;;
			-M) create_home= ;;
			*) die "${FUNCNAME}: invalid option $1" ;;
		esac
		shift
	done

	local user=$1 uid=$2 shell=$3 home=$4 groups=$5 ; shift $(( $# ))
	[[ -n ${user} ]] || die "${FUNCNAME}: no username"

	# skip if user exists
	[[ -n $(egetent passwd "${user}") ]] && return 0
	elog "Adding user '${user}' ..."

	local opts=()
	[[ -n ${ROOT} ]] && opts+=( --prefix "${ROOT}" )

	# ---- uid ----------------------------------------------------------------
	if [[ -n ${uid} && ${uid} != -1 ]]; then
		[[ ${uid} =~ ^[0-9]+$ && ${uid} -ge 0 ]] \
			|| die "${FUNCNAME}: invalid UID '${uid}'"
		[[ -z $(egetent passwd "${uid}") ]] || {
			[[ ${force_uid} ]] && die "${FUNCNAME}: UID ${uid} taken"
			uid=
		}
	fi
	if [[ -z ${uid} ]]; then
		for ((uid = 999; uid >= 101; uid--)); do
			[[ -z $(egetent passwd "${uid}") ]] && break
		done
		[[ ${uid} -ge 101 ]] || die "${FUNCNAME}: no free UID"
	fi
	opts+=( -u ${uid} )
	elog " - uid: ${uid}"

	# ---- shell --------------------------------------------------------------
	if [[ -z ${shell} || ${shell} == -1 ]]; then
		shell=$(user_get_nologin)
	fi
	[[ -e ${ROOT%/}${shell} ]] || die "${FUNCNAME}: shell ${shell} missing"
	opts+=( -s "${shell}" )
	elog " - shell: ${shell}"

	# ---- home ---------------------------------------------------------------
	[[ -z ${home} || ${home} == -1 ]] && home=/dev/null
	opts+=( -d "${home}" )
	elog " - home: ${home}"

	# ---- groups -------------------------------------------------------------
	local defgroup exgroups
	if [[ -n ${groups} ]]; then
		IFS=',' read -r -a _g <<< "${groups}"
		for g in "${_g[@]}"; do
			[[ -n $(egetent group "${g}") ]] \
				|| die "${FUNCNAME}: group ${g} missing"
			[[ -z ${defgroup} ]] && defgroup=${g} || exgroups+=",${g}"
		done
	fi
	[[ -n ${defgroup} ]] && opts+=( -g "${defgroup}" )
	[[ -n ${exgroups} ]] && opts+=( -G "${exgroups#,}" )
	elog " - groups: ${groups:-none}"

	opts+=( -c "" )

	useradd -M -N -r "${opts[@]}" "${user}" || die

	# create home if requested
	if [[ ${create_home} && ! -e ${ROOT%/}${home} ]]; then
		elog " - creating ${home}"
		mkdir -p "${ROOT%/}${home}"
		chown "${uid}:${defgroup:-0}" "${ROOT%/}${home}"
		chmod 755 "${ROOT%/}${home}"
	fi
}

# ---------------------------------------------------------------------------
# add group
# ---------------------------------------------------------------------------
enewgroup() {
	[[ ${EUID} -eq 0 ]] || { ewarn "need root to add groups"; return 0; }
	_user_assert_pkg_phase ${FUNCNAME}

	local force gid
	while [[ $1 == -* ]]; do
		[[ $1 == -F ]] && force=1 || die "${FUNCNAME}: bad option $1"
		shift
	done

	local group=$1 ; gid=$2
	[[ -n ${group} ]] || die "${FUNCNAME}: no group"

	[[ -n $(egetent group "${group}") ]] && return 0
	elog "Adding group '${group}' ..."

	if [[ -n ${gid} && ${gid} != -1 ]]; then
		[[ ${gid} =~ ^[0-9]+$ && ${gid} -ge 0 ]] \
			|| die "${FUNCNAME}: bad gid ${gid}"
		[[ -z $(egetent group "${gid}") ]] || {
			[[ ${force} ]] && die "${FUNCNAME}: gid ${gid} taken"
			gid=
		}
	fi
	if [[ -z ${gid} ]]; then
		for ((gid = 999; gid >= 101; gid--)); do
			[[ -z $(egetent group "${gid}") ]] && break
		done
		[[ ${gid} -ge 101 ]] || die "${FUNCNAME}: no free gid"
	fi
	elog " - gid: ${gid}"

	local opts=( -g ${gid} -r )
	[[ -n ${ROOT} ]] && opts+=( --prefix "${ROOT}" )

	groupadd "${opts[@]}" "${group}" || die
}

# ---------------------------------------------------------------------------
# attribute setters (home / shell / comment / groups)
# Linux only → one code path
# ---------------------------------------------------------------------------
_esafe_usermod() {
	local what=$1 ; shift
	usermod "$@" && return
	[[ $? == 8 ]] && eerror "user in use; cannot update ${what}"
	die "Failed to update ${what} for $*"
}

esethome() {
	_user_assert_pkg_phase ${FUNCNAME}
	[[ $# -eq 2 ]] || die "usage: esethome <user> <home|-1>"

	local user=$1 home=$2
	[[ -n $(egetent passwd "${user}") ]] || { ewarn "user missing"; return 1; }

	[[ ${home} == -1 || -z ${home} ]] && home=/dev/null
	[[ $(egethome "${user}") == ${home} ]] && return 0

	elog "Updating home for ${user} -> ${home}"
	[[ ! -e ${ROOT%/}${home} ]] && mkdir -p "${ROOT%/}${home}"
	chown "${user}" "${ROOT%/}${home}" ; chmod 755 "${ROOT%/}${home}"

	local opts=( -d "${home}" )
	[[ -n ${ROOT} ]] && opts+=( --prefix "${ROOT}" )
	_esafe_usermod home "${opts[@]}" "${user}"
}

esetshell() {
	_user_assert_pkg_phase ${FUNCNAME}
	[[ $# -eq 2 ]] || die "usage: esetshell <user> <shell|-1>"

	local user=$1 shell=$2
	[[ -n $(egetent passwd "${user}") ]] || { ewarn "user missing"; return 1; }

	[[ ${shell} == -1 || -z ${shell} ]] && shell=$(user_get_nologin)
	[[ $(egetshell "${user}") == ${shell} ]] && return 0

	elog "Updating shell for ${user} -> ${shell}"
	local opts=( -s "${shell}" )
	[[ -n ${ROOT} ]] && opts+=( --prefix "${ROOT}" )
	_esafe_usermod shell "${opts[@]}" "${user}"
}

esetcomment() {
	_user_assert_pkg_phase ${FUNCNAME}
	[[ $# -eq 2 ]] || die "usage: esetcomment <user> <comment>"

	local user=$1 comment=$2
	[[ -n $(egetent passwd "${user}") ]] || { ewarn "user missing"; return 1; }
	[[ $(egetcomment "${user}") == ${comment} ]] && return 0

	local opts=( -c "${comment}" )
	[[ -n ${ROOT} ]] && opts+=( --prefix "${ROOT}" )
	_esafe_usermod comment "${opts[@]}" "${user}"
}

esetgroups() {
	_user_assert_pkg_phase ${FUNCNAME}
	[[ $# -eq 2 ]] || die "usage: esetgroups <user> <grp1,grp2,...>"

	local user=$1 groups_raw=$2
	[[ -n $(egetent passwd "${user}") ]] || { ewarn "user missing"; return 1; }

	local IFS=',' g_arr=(${groups_raw})
	for g in "${g_arr[@]}"; do
		[[ -n $(egetent group "${g}") ]] \
			|| die "group ${g} missing; add it first"
	done

	local primary=${g_arr[0]}
	local sup=$(printf '%s\n' "${g_arr[@]:1}" | sort | tr '\n' ',' | sed 's/,$//')
	[[ $(egetgroups "${user}") == "${groups_raw}" ]] && return 0

	local opts=( -g "${primary}" )
	[[ -n ${sup} ]] && opts+=( -G "${sup}" )
	[[ -n ${ROOT} ]] && opts+=( --prefix "${ROOT}" )
	_esafe_usermod groups "${opts[@]}" "${user}"
}

fi  # _USER_ECLASS

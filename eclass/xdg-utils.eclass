# Copyright 2004-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: xdg-utils.eclass
# @SUPPORTED_EAPIS: 5 6 7 8
# @BLURB: Auxiliary functions commonly used by XDG-compliant packages

case ${EAPI} in
	5|6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

inherit emoji          # adds ICON_* vars and log_* helpers

# ——— internal defaults ————————————————————————————————————————
: "${DESKTOP_DATABASE_DIR:=/usr/share/applications}"
: "${MIMEINFO_DATABASE_DIR:=/usr/share/mime}"

# ——— helpers ————————————————————————————————————————————————
_xdg_assert_post() { [[ ${EBUILD_PHASE} == post* ]] \
	|| die "${ICON_BAD} $1 must be used in pkg_post* phases"; }

_xdg_have() { command -v "$1" &>/dev/null; }

# ——— public api ————————————————————————————————————————————
xdg_environment_reset() {
	export XDG_DATA_HOME="${HOME}/.local/share"
	export XDG_CONFIG_HOME="${HOME}/.config"
	export XDG_CACHE_HOME="${HOME}/.cache"
	export XDG_STATE_HOME="${HOME}/.local/state"
	export XDG_RUNTIME_DIR="${T}/run"

	mkdir -p "${XDG_DATA_HOME}" "${XDG_CONFIG_HOME}" "${XDG_CACHE_HOME}" \
	        "${XDG_STATE_HOME}" "${XDG_RUNTIME_DIR}" || die
	chmod 0700 "${XDG_RUNTIME_DIR}" || die
	unset DBUS_SESSION_BUS_ADDRESS
}

# .desktop cache — supports -q
xdg_desktop_database_update() {
	_xdg_assert_post xdg_desktop_database_update
	_xdg_have update-desktop-database || { log_err "update-desktop-database not found"; return; }

	if update-desktop-database -q "${EROOT%/}${DESKTOP_DATABASE_DIR}"; then
		log_ok ".desktop cache updated (${EBUILD_PHASE})"
	else
		log_err "Failed to update .desktop cache (${EBUILD_PHASE})"
	fi
}

# icon cache
xdg_icon_cache_update() {
	_xdg_assert_post xdg_icon_cache_update
	_xdg_have gtk-update-icon-cache || { log_err "gtk-update-icon-cache not found"; return; }

	local dir rc=0 failed=()
	for dir in "${EROOT%/}"/usr/share/icons/*; do
		[[ -d ${dir} ]] || continue
		if [[ -f ${dir}/index.theme ]]; then
			gtk-update-icon-cache -qf "${dir}" || { failed+=( "${dir}" ); rc=1; }
		else
			[[ -f ${dir}/icon-theme.cache ]] && rm -f "${dir}/icon-theme.cache"
			[[ -z $(ls -A "${dir}") ]] && rmdir "${dir}"
		fi
	done
	(( rc == 0 )) && log_ok "icon cache updated (${EBUILD_PHASE})" || log_err "icon cache update had errors (${EBUILD_PHASE})"
	for dir in "${failed[@]}"; do log_warn "update failed in ${dir}"; done
}

xdg_mimeinfo_database_update() {
	_xdg_assert_post xdg_mimeinfo_database_update
	_xdg_have update-mime-database || { log_err "update-mime-database not found"; return; }

	local -x PKGSYSTEM_ENABLE_FSYNC=0

	if update-mime-database "${EROOT%/}${MIMEINFO_DATABASE_DIR}"; then
		log_ok "shared MIME database updated (${EBUILD_PHASE})"
	else
		log_err "Failed to update shared MIME database (${EBUILD_PHASE})"
	fi
}

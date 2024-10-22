# Distributed under the terms of the GNU General Public License v2

# @ECLASS: doins.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Helper functions to install files in standard directories for bash-completion, tmpfiles.d, and systemd units.
# @DESCRIPTION: This eclass provides utility functions for installing files

EAPI=8

inherit toolchain-funcs

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

# ----------------- Bash Completion Functions -----------------

_bash-completion-r1_get_bashdir() {
	if $(tc-getPKG_CONFIG) --exists bash-completion &>/dev/null; then
		local path
		path=$($(tc-getPKG_CONFIG) --variable="${1}" bash-completion) || die
		echo "${path#${EPREFIX}}"
	else
		echo "${2}"
	fi
}

get_bashcompdir() {
	echo "${EPREFIX}$(_bash-completion-r1_get_bashdir completionsdir /usr/share/bash-completion/completions)"
}

dobashcomp() {
	insopts -m 0644
	insinto "$(get_bashcompdir)"
	doins "${@}"
}

newbashcomp() {
	insopts -m 0644
	insinto "$(get_bashcompdir)"
	newins "${@}"
}

bashcomp_alias() {
	[[ ${#} -lt 2 ]] && die "Usage: ${FUNCNAME} <basename> <alias>..."
	local base=${1}
	shift

	for f; do
		dosym "${base}" "$(get_bashcompdir)/${f}" || return
	done
}

# ----------------- Tmpfiles -----------------

dotmpfiles() {
	insopts -m 0644
	insinto /usr/lib/tmpfiles.d
	doins "$@"
}

newtmpfiles() {
	[[ $2 != *.conf ]] && die "tmpfiles.d files must end with .conf"
	insopts -m 0644
	insinto /usr/lib/tmpfiles.d
	newins "$@"
}

tmpfiles_process() {
	[[ ${EBUILD_PHASE} == postinst ]] || die "${FUNCNAME}: Only valid in pkg_postinst"
	[[ ${#} -gt 0 ]] || die "${FUNCNAME}: Must specify at least one filename"

	if [[ ${ROOT:-/} != / ]]; then
		ewarn "Warning: tmpfiles.d not processed on ROOT != /. Run 'tmpfiles --create' after booting into the ROOT."
		return
	fi

	if type systemd-tmpfiles &> /dev/null; then
		systemd-tmpfiles --create "$@"
	elif type tmpfiles &> /dev/null; then
		tmpfiles --create "$@"
	fi
	if [[ $? -ne 0 ]]; then
		ewarn "The tmpfiles processor exited with a non-zero exit code"
	fi
}

# ----------------- Systemd -----------------

_systemd_get_dir() {
	[[ ${#} -eq 2 ]] || die "Usage: ${FUNCNAME} <variable-name> <fallback-directory>"
	local variable=${1} fallback=${2}
	if $(tc-getPKG_CONFIG) --exists systemd; then
		local d
		d=$($(tc-getPKG_CONFIG) --variable="${variable}" systemd) || die
		echo "${d}"
	else
		echo "${EPREFIX}${fallback}"
	fi
}

systemd_get_systemunitdir() {
	_systemd_get_dir systemdsystemunitdir /lib/systemd/system
}

systemd_get_userunitdir() {
	_systemd_get_dir systemduserunitdir /usr/lib/systemd/user
}

systemd_dounit() {
	insopts -m 0644
	insinto "$(systemd_get_systemunitdir)"
	doins "${@}"
}

systemd_newunit() {
	insopts -m 0644
	insinto "$(systemd_get_systemunitdir)"
	newins "${@}"
}

systemd_douserunit() {
	insopts -m 0644
	insinto "$(systemd_get_userunitdir)"
	doins "${@}"
}

systemd_newuserunit() {
	insopts -m 0644
	insinto "$(systemd_get_userunitdir)"
	newins "${@}"
}

systemd_enable_service() {
	[[ ${#} -eq 2 ]] || die "Synopsis: systemd_enable_service target service"
	local target=${1} service=${2}
	local unitdir=$(systemd_get_systemunitdir)
	dodir "${unitdir}/${target}.wants"
	dosym "../${service}" "${unitdir}/${target}.wants/${service##*/}"
}

systemd_update_catalog() {
	[[ ${EBUILD_PHASE} == post* ]] || die "${FUNCNAME} disallowed during ${EBUILD_PHASE_FUNC:-${EBUILD_PHASE}}"
	local journalctl=${EPREFIX}/usr/bin/journalctl
	if [[ -x ${journalctl} ]]; then
		ebegin "Updating systemd journal catalogs"
		journalctl --update-catalog
		eend $?
	else
		debug-print "${FUNCNAME}: journalctl not found."
	fi
}
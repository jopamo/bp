# Distributed under the terms of the GNU General Public License v2

# @ECLASS: doins.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Helper functions to install files in standard directories for bash-completion, tmpfiles.d, and systemd units.
# @DESCRIPTION: This eclass provides utility functions for installing files

if [[ -z ${_DOINS_ECLASS} ]]; then
_DOINS_ECLASS=1

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

	if [[ ${ROOT:-/} != / ]]; then
		ewarn "Warning: tmpfiles.d not processed on ROOT != /. Run 'tmpfiles --create' after booting into the ROOT."
		return
	fi

	if type systemd-tmpfiles &> /dev/null; then
		systemd-tmpfiles --create
	elif type tmpfiles &> /dev/null; then
		tmpfiles --create
	fi
	if [[ $? -ne 0 ]]; then
		ewarn "The tmpfiles processor exited with a non-zero exit code"
	fi
}

# install one or more *.conf files with default perms
dosysusers() {
	insopts -m 0644
	insinto /usr/lib/sysusers.d
	doins "$@"
}

# install a single file, renaming on the fly, and sanity-check the suffix
newsysusers() {
	[[ $2 != *.conf ]] && die "sysusers.d files must end with .conf"
	insopts -m 0644
	insinto /usr/lib/sysusers.d
	newins "$@"
}

sysusers_process() {
	[[ ${EBUILD_PHASE} == postinst ]] || die "${FUNCNAME}: Only valid in pkg_postinst"

	# skip when merging to an alternative ROOT, advise manual run later
	if [[ ${ROOT:-/} != / ]]; then
		ewarn "Warning: sysusers.d not processed on ROOT != /. Run 'systemd-sysusers' after booting into the ROOT"
		return
	fi

	# prefer the systemd implementation, fall back to busybox sysusers if present
	if type systemd-sysusers &>/dev/null; then
		systemd-sysusers           # no arguments → process the whole directory
	elif type sysusers &>/dev/null; then
		sysusers                   # busybox or compatible helper
	fi

	[[ $? -eq 0 ]] || ewarn "The sysusers processor exited with a non-zero exit code"
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

udev_reload() {
	if [[ -n ${ROOT} ]]; then
		return 0
	fi

	if [[ -d ${ROOT}/run/udev ]]; then
		ebegin "Running udev control --reload for reloading rules and databases"
		udevadm control --reload
		eend $?
	fi
}

get_udevdir() {
	echo /usr/lib/udev
}

udev_newrules() {
	debug-print-function ${FUNCNAME} "$@"

	(
		insopts -m 0644
		insinto "$(get_udevdir)"/rules.d
		newins "${@}"
	)
}

make_wrapper() {
	local wrapper=$1        # installed name
	local bin=$2            # command to exec (default = wrapper)
	local chdir=$3          # working dir (optional)
	local libdir=$4         # new LD_LIBRARY_PATH entry (optional)
	local path=$5           # install dir for the wrapper (optional)

	[[ -z ${wrapper} ]] && die "make_wrapper requires at least <wrapper>"

	# default bin to wrapper if not given
	[[ -z ${bin} ]] && bin=${wrapper}

	local tmpwrapper="${T}/tmp.wrapper.${wrapper##*/}"

	# --------------------------------------------------------------------
	# build the script
	# --------------------------------------------------------------------
	(
		printf '%s\n' '#!/bin/sh'

		if [[ -n ${libdir} ]]; then
			# expand EPREFIX at build time, so runtime shell sees a literal path
			local abs_lib="${EPREFIX}${libdir#/}"
			cat <<-SH
				# prepend ${abs_lib} to LD_LIBRARY_PATH if not already present
				new_path="${abs_lib}"
				case ":\\\${LD_LIBRARY_PATH:-}:" in
				    *:"\${new_path}":*) ;;                                # already there
				    ''|:)  LD_LIBRARY_PATH="\${new_path}" ;;              # was empty
				    *)     LD_LIBRARY_PATH="\${LD_LIBRARY_PATH:+\${LD_LIBRARY_PATH}:}\${new_path}" ;;
				esac
				export LD_LIBRARY_PATH
			SH
		fi

		# optional working directory
		if [[ -n ${chdir} ]]; then
			printf 'cd "%s" || exit 1\n' "${EPREFIX}${chdir#/}"
		fi

		# exec target (prefix absolute path with EPREFIX if needed)
		if [[ ${bin} == /* ]]; then
			printf 'exec "%s" "$@"\n' "${EPREFIX}${bin#/}"
		else
			printf 'exec %s "$@"\n' "${bin}"
		fi
	) > "${tmpwrapper}" || die

	chmod 0755 "${tmpwrapper}" || die

	# --------------------------------------------------------------------
	# install
	# --------------------------------------------------------------------
	if [[ -n ${path} ]]; then
		exeopts -m 0755
		exeinto "${path}"
		newexe "${tmpwrapper}" "${wrapper}" || die
	else
		newbin "${tmpwrapper}" "${wrapper}" || die
	fi
}

fi

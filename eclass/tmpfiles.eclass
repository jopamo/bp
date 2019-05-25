# Distributed under the terms of the GNU General Public License v2

if [[ -z ${TMPFILES_ECLASS} ]]; then
TMPFILES_ECLASS=1

case "${EAPI}" in
5|6|7) ;;
*) die "API is undefined for EAPI ${EAPI}" ;;
esac

# @FUNCTION: dotmpfiles
# @USAGE: dotmpfiles <tmpfiles.d_file> ...
# @DESCRIPTION:
# Install one or more tmpfiles.d files into /usr/lib/tmpfiles.d.
dotmpfiles() {
	debug-print-function "${FUNCNAME}" "$@"

	local f
	for f; do
		if [[ ${f} != *.conf ]]; then
			die "tmpfiles.d files must end with .conf"
		fi
	done

	(
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		doins "$@"
	)
}

# @FUNCTION: newtmpfiles
# @USAGE: newtmpfiles <old-name> <new-name>.conf
# @DESCRIPTION:
# Install a tmpfiles.d file in /usr/lib/tmpfiles.d under a new name.
newtmpfiles() {
	debug-print-function "${FUNCNAME}" "$@"

	if [[ $2 != *.conf ]]; then
		die "tmpfiles.d files must end with .conf"
	fi

	(
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		newins "$@"
	)
}

# @FUNCTION: tmpfiles_process
# @USAGE: tmpfiles_process <filename> <filename> ...
# @DESCRIPTION:
# Call a tmpfiles.d implementation to create new volatile and temporary
# files and directories.
tmpfiles_process() {
	debug-print-function "${FUNCNAME}" "$@"

	[[ ${EBUILD_PHASE} == postinst ]] || die "${FUNCNAME}: Only valid in pkg_postinst"
	[[ ${#} -gt 0 ]] || die "${FUNCNAME}: Must specify at least one filename"

	# Only process tmpfiles for the currently running system
	if [[ "${ROOT}"/ != / ]]; then
		ewarn "Warning: tmpfiles.d not processed on ROOT != /."
		return
	fi

	if type systemd-tmpfiles &> /dev/null; then
		systemd-tmpfiles --create "$@"
	fi
	if [[ $? -ne 0 ]]; then
		ewarn "The tmpfiles processor exited with a non-zero exit code"
	fi
}

fi

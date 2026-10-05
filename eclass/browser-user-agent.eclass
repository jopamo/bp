# Distributed under the terms of the GNU General Public License v2

# @ECLASS: browser-user-agent.eclass
# @SUPPORTED_EAPIS: 8
# @BLURB: Resolve distro browser versions for compatibility identities

if [[ -z ${_BROWSER_USER_AGENT_ECLASS:-} ]]; then
_BROWSER_USER_AGENT_ECLASS=1
_BP_BROWSER_REPO=${BASH_SOURCE[0]%/eclass/*}

case ${EAPI} in
	8) ;;
	*) die "browser-user-agent.eclass requires EAPI 8" ;;
esac

# Only release versions from the selected stable package names are candidates.
_bp_browser_release() {
	local version=${1%-r*}
	[[ $1 =~ ^[1-9][0-9]*(\.[0-9]+)*(-r[0-9]+)?$ && ${version%%.*} != 9999 ]]
}

_bp_browser_version() {
	local atom cpv version path best
	for atom in "$@"; do
		cpv=$(best_version -r "${atom}") || cpv=
		[[ ${cpv} == "${atom}-"* ]] || continue
		version=${cpv#"${atom}-"}
		if _bp_browser_release "${version}"; then
			printf '%s\n' "${version%-r*}"
			return
		fi
	done

	for atom in "$@"; do
		best=
		for path in "${_BP_BROWSER_REPO}/${atom}/${atom#*/}-"*.ebuild; do
			[[ -f ${path} ]] || continue
			version=${path##*/}
			version=${version#"${atom#*/}-"}
			version=${version%.ebuild}
			_bp_browser_release "${version}" || continue
			if [[ -z ${best} ]] || ver_test "${version}" -gt "${best}"; then
				best=${version}
			fi
		done
		if [[ -n ${best} ]]; then
			printf '%s\n' "${best%-r*}"
			return
		fi
	done
	return 0
}

# @FUNCTION: bp_browser_versions
# @DESCRIPTION:
# Set BP_CHROME_VERSION and BP_FIREFOX_VERSION from installed stable packages,
# then this repository's release ebuilds. Missing families produce empty values.
# No browser dependencies or executable probes are added. meson.eclass appends
# user MYMESONARGS after emesonargs, so explicit Meson values still win.
bp_browser_versions() {
	BP_CHROME_VERSION=$(_bp_browser_version bin/google-chrome bin/chromium)
	BP_FIREFOX_VERSION=$(_bp_browser_version xgui-app/firefox)
}

fi

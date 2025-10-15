# Distributed under the terms of the GNU General Public License v2

# @ECLASS: alternatives.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Creates symlink to the latest version of multiple slotted packages
# @DESCRIPTION:
# When a package is SLOTed, you often want a stable symlink pointing at the newest installed alternative
# This eclass picks the newest existing target from a list and creates the symlink accordingly

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_ALTERNATIVES_ECLASS} ]]; then
_ALTERNATIVES_ECLASS=1

# @ECLASS_VARIABLE: SOURCE
# @DEFAULT_UNSET
# @DESCRIPTION:
# The symlink to be created

# @ECLASS_VARIABLE: ALTERNATIVES
# @DEFAULT_UNSET
# @DESCRIPTION:
# Space separated list of candidate targets in descending preference

# internal helper to test if coreutils ln supports --relative
_alternatives_ln_supports_relative() {
	ln --help 2>/dev/null | grep -q -- ' --relative\>'
}

# pick a sort that is version aware if available
_alternatives_sort_desc() {
	if sort -V </dev/null >/dev/null 2>&1; then
		sort -rV
	else
		sort -r
	fi
}

# @FUNCTION: alternatives_auto_makesym
# @DESCRIPTION:
# Build alternatives list from a glob mask and create the symlink
# usage: alternatives_auto_makesym <symlink> <glob-mask>
alternatives_auto_makesym() {
	local symlink=$1
	local mask=$2
	local myglob

	if [[ -z ${symlink} || -z ${mask} ]]; then
		die "alternatives_auto_makesym requires a symlink and a glob mask"
	fi

	# if mask is not absolute, inherit the directory of the symlink
	if [[ ${mask:0:1} != "/" ]]; then
		myglob="${symlink%/*}/${mask}"
	else
		myglob=${mask}
	fi

	# expand glob within EROOT, then strip EROOT so alternatives_makesym can reapply prefixes uniformly
	# use compgen instead of echo to avoid word splitting and unexpanded globs
	local -a found=()
	local g
	while IFS= read -r g; do
		# only keep entries that actually exist under EROOT
		[[ -e ${g} ]] || continue
		found+=( "${g#${EROOT%/}}" )
	done < <(compgen -G "${EROOT%/}${myglob}" 2>/dev/null | _alternatives_sort_desc)

	if [[ ${#found[@]} -eq 0 ]]; then
		ewarn "No alternatives matched '${myglob}' under ${EROOT}"
		return 0
	fi

	alternatives_makesym "${symlink}" "${found[@]}"
}

# @FUNCTION: alternatives_makesym
# @DESCRIPTION:
# Create or update the symlink to point at the first existing target
# usage: alternatives_makesym <symlink> <alt1> [alt2 ...]
alternatives_makesym() {
	local symlink=$1
	shift || true

	if [[ -z ${symlink} || $# -eq 0 ]]; then
		die "alternatives_makesym requires a symlink and at least one alternative target"
	fi

	# normalize into EPREFIX and EROOT domains
	# ensure symlink path is within EPREFIX
	local link_path="${EPREFIX%/}/${symlink#${EPREFIX%/}/}"
	# operations happen against the live fs in postinst/postrm, use EROOT
	local root="${EROOT%/}"

	# iterate over the provided alternatives in order
	local alt
	for alt in "$@"; do
		# normalize alt into EPREFIX
		local norm_alt="${EPREFIX%/}/${alt#${EPREFIX%/}/}"
		if [[ -e ${root}${norm_alt} ]]; then
			# try to use ln --relative when available and the user didn't explicitly require absolute
			if _alternatives_ln_supports_relative; then
				einfo "Linking ${root}${norm_alt} -> ${root}${link_path} using relative target"
				ln -sfn --relative -- "${root}${norm_alt}" "${root}${link_path}" || die
			else
				# if both in same dir, prefer a relative basename to keep trees relocatable
				if [[ ${norm_alt%/*} == ${link_path%/*} ]]; then
					einfo "Linking ${norm_alt##*/} -> ${root}${link_path} (relative)"
					ln -sfn -- "${norm_alt##*/}" "${root}${link_path}" || die
				else
					einfo "Linking ${root}${norm_alt} -> ${root}${link_path} (absolute)"
					ln -sfn -- "${root}${norm_alt}" "${root}${link_path}" || die
				fi
			fi
			break
		fi
	done

	# report errors or prune dead links
	if [[ ! -L ${root}${link_path} ]]; then
		ewarn "Unable to establish ${root}${link_path} symlink"
	else
		# resolve link target and verify existence both as relative to dirname and absolute
		local target
		if ! target=$(readlink -- "${root}${link_path}"); then
			ewarn "readlink failed for ${root}${link_path}"
			return 0
		fi
		if [[ ! -e $(dirname -- "${root}${link_path}")/${target} && ! -e ${target} ]]; then
			ewarn "Removing dead symlink ${root}${link_path}"
			rm -f -- "${root}${link_path}" || die
		fi
	fi
}

# shared tail for pkg_postinst/pkg_postrm
_alternatives_run_for_vars() {
	if [[ -n ${ALTERNATIVES} && -n ${SOURCE} ]]; then
		# expand $ALTERNATIVES into an array to preserve items with spaces
		local -a alts=()
		# shellcheck disable=SC2206
		alts=( ${ALTERNATIVES} )
		alternatives_makesym "${SOURCE}" "${alts[@]}"
	fi
}

# @FUNCTION: alternatives_pkg_postinst
# @DESCRIPTION:
# Run alternatives after install
alternatives_pkg_postinst() {
	_alternatives_run_for_vars
}

# @FUNCTION: alternatives_pkg_postrm
# @DESCRIPTION:
# Reevaluate alternatives after removal
alternatives_pkg_postrm() {
	_alternatives_run_for_vars
}

fi

EXPORT_FUNCTIONS pkg_postinst pkg_postrm

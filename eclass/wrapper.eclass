# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: wrapper.eclass
# @BLURB: create simple shell-wrapper scripts

case ${EAPI} in
	5|6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_WRAPPER_ECLASS} ]]; then
_WRAPPER_ECLASS=1

# ---------------------------------------------------------------------------
# @FUNCTION: make_wrapper
# @USAGE: <wrapper> <target> [chdir] [libpaths] [installpath]
# @DESCRIPTION:
#   Create an executable shell script <wrapper> (installed into <installpath>
#   or ${BROOT}/usr/bin by default) that:
#      1. Optionally prepends <libpaths> to LD_LIBRARY_PATH
#         without introducing empty ':' components or duplicates.
#      2. Optionally cd's to <chdir>.
#      3. exec's <target> "$@" (honours EPREFIX on absolute paths).
#
#   Examples:
#       make_wrapper foo /opt/foo/bin/foo               # simple call
#       make_wrapper bar ./barbin /opt/bar '' /usr/games # with chdir and path
#
#   All parameters except <wrapper> are optional but positional.
# ---------------------------------------------------------------------------
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

fi  # _WRAPPER_ECLASS

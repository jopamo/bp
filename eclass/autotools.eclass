# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: autotools.eclass
# @MAINTAINER:
# base-system@gentoo.org
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Regenerates auto* build scripts
# @DESCRIPTION:
# This eclass is for safely handling autotooled software packages that need to
# regenerate their build scripts.  All functions will abort in case of errors.

# Note: We require GNU m4, as does autoconf.  So feel free to use any features
# from the GNU version of m4 without worrying about other variants (i.e. BSD).

if [[ ${_AUTOTOOLS_AUTO_DEPEND+set} == "set" ]] ; then
	# See if we were included already, but someone changed the value
	# of AUTOTOOLS_AUTO_DEPEND on us.  We could reload the entire
	# eclass at that point, but that adds overhead, and it's trivial
	# to re-order inherit in eclasses/ebuilds instead.  #409611
	if [[ ${_AUTOTOOLS_AUTO_DEPEND} != ${AUTOTOOLS_AUTO_DEPEND} ]] ; then
		die "AUTOTOOLS_AUTO_DEPEND changed value between inherits; please inherit ${ECLASS} first! ${_AUTOTOOLS_AUTO_DEPEND} -> ${AUTOTOOLS_AUTO_DEPEND}"
	fi
fi

if [[ -z ${_AUTOTOOLS_ECLASS} ]] ; then
_AUTOTOOLS_ECLASS=1

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

GNUCONFIG_AUTO_DEPEND=no
inherit gnuconfig libtool

# @ECLASS_VARIABLE: AUTOTOOLS_DEPEND
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Contains the combination of requested automake/autoconf/libtool
# versions in *DEPEND format.
AUTOTOOLS_DEPEND="
	${GNUCONFIG_DEPEND}
	${_automake_atom}
	${_autoconf_atom}
	${_libtool_atom}
"
RDEPEND=""

# @ECLASS_VARIABLE: AUTOTOOLS_AUTO_DEPEND
# @PRE_INHERIT
# @DESCRIPTION:
# Set to 'no' to disable automatically adding to DEPEND.  This lets
# ebuilds form conditional depends by using ${AUTOTOOLS_DEPEND} in
# their own DEPEND string.
: "${AUTOTOOLS_AUTO_DEPEND:=yes}"
[[ ${AUTOTOOLS_AUTO_DEPEND} != "no" ]] && BDEPEND=${AUTOTOOLS_DEPEND}
_AUTOTOOLS_AUTO_DEPEND=${AUTOTOOLS_AUTO_DEPEND} # See top of eclass

unset _automake_atom _autoconf_atom

# @ECLASS_VARIABLE: AM_OPTS
# @DEFAULT_UNSET
# @DESCRIPTION:
# Additional options to pass to automake during
# eautoreconf call.
: "${AM_OPTS:=}"

# @ECLASS_VARIABLE: AT_NOEAUTOHEADER
# @DEFAULT_UNSET
# @DESCRIPTION:
# Don't run eautoheader command if set to 'yes'; only used to work around
# packages that don't want their headers being modified.
: "${AT_NOEAUTOHEADER:=}"

# @ECLASS_VARIABLE: AT_NOEAUTOMAKE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Don't run eautomake command if set to 'yes'; only used to workaround
# broken packages.  Generally you should, instead, fix the package to
# not call AM_INIT_AUTOMAKE if it doesn't actually use automake.
: "${AT_NOEAUTOMAKE:=}"

# @ECLASS_VARIABLE: AT_NOELIBTOOLIZE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Don't run elibtoolize command if set to 'yes',
# useful when elibtoolize needs to be ran with
# particular options
: "${AT_NOELIBTOOLIZE:=}"

# @ECLASS_VARIABLE: AT_M4DIR
# @DEFAULT_UNSET
# @DESCRIPTION:
# Additional director(y|ies) aclocal should search
: "${AT_M4DIR:=}"

# @ECLASS_VARIABLE: AT_SYS_M4DIR
# @DEFAULT_UNSET
# @INTERNAL
# @DESCRIPTION:
# For system integrators, a list of additional aclocal search paths.
# This variable gets eval-ed, so you can use variables in the definition
# that may not be valid until eautoreconf & friends are run.
: "${AT_SYS_M4DIR:=}"

# @FUNCTION: eautoreconf
# @DESCRIPTION:
# This function mimes the behavior of autoreconf, but uses the different
# eauto* functions to run the tools. It doesn't accept parameters, but
# the directory with include files can be specified with AT_M4DIR variable.
#
# Should do a full autoreconf - normally what most people will be interested in.
# Also should handle additional directories specified by AC_CONFIG_SUBDIRS.
eautoreconf() {
	local x g

	# Subdirs often share a common build dir, bug #529404.  If so, we can't safely
	# run in parallel because many tools clobber the content in there.  Libtool
	# and automake both `rm && cp` while aclocal reads the output.  We might be
	# able to handle this if we split the steps and grab locks on the dirs the
	# tools actually write to.  Then we'd run all the common tools that use
	# those inputs.  Doing this in bash does not scale easily.
	# If we do re-enable parallel support, make sure bug #426512 is handled.
	if [[ -z ${AT_NO_RECURSIVE} ]] ; then
		# Take care of subdirs
		for x in $(autotools_check_macro_val AC_CONFIG_SUBDIRS) ; do
			if [[ -d ${x} ]] ; then
				pushd "${x}" >/dev/null
				# Avoid unsafe nested multijob_finish_one for bug #426512.
				AT_NOELIBTOOLIZE="yes" eautoreconf || die
				popd >/dev/null
			fi
		done
	fi

	einfo "Running eautoreconf in '${PWD}' ..."

	local m4dirs=$(autotools_check_macro_val AC_CONFIG_{AUX,MACRO}_DIR)
	[[ -n ${m4dirs} ]] && mkdir -p ${m4dirs}

	# Run all the tools before aclocal so we can gather the .m4 files.
	local i tools=(
		# <tool> <was run> <command>
		glibgettext false "autotools_run_tool glib-gettextize --copy --force"
		gettext     false "autotools_run_tool --at-missing autopoint --force"
		# intltool must come after autopoint.
		intltool    false "autotools_run_tool intltoolize --automake --copy --force"
		gtkdoc      false "autotools_run_tool --at-missing gtkdocize --copy"
		gnomedoc    false "autotools_run_tool --at-missing gnome-doc-prepare --copy --force"
		libtool     false "_elibtoolize --auto-ltdl --install --copy --force"
	)
	for (( i = 0; i < ${#tools[@]}; i += 3 )) ; do
		if _at_uses_${tools[i]} ; then
			tools[i+1]=true
			${tools[i+2]}
		fi
	done

	# Generate aclocal.m4 with our up-to-date m4 files.
	local rerun_aclocal=false
	eaclocal

	# Check to see if we had macros expanded by other macros or in other
	# m4 files that we couldn't detect early.  This is uncommon, but some
	# packages do this, so we have to handle it correctly.
	for (( i = 0; i < ${#tools[@]}; i += 3 )) ; do
		if ! ${tools[i+1]} && _at_uses_${tools[i]} ; then
			${tools[i+2]}
			rerun_aclocal=true
		fi
	done
	${rerun_aclocal} && eaclocal

	eautoconf --force

	if [[ ${AT_NOEAUTOHEADER} != "yes" ]] ; then
		eautoheader --force
	fi
	[[ ${AT_NOEAUTOMAKE} != "yes" ]] && FROM_EAUTORECONF="yes" eautomake ${AM_OPTS}

	if [[ ${AT_NOELIBTOOLIZE} != "yes" ]] ; then
		# Call it here to prevent failures due to elibtoolize called _before_
		# eautoreconf.
		elibtoolize --force "${PWD}"
	fi

	return 0
}

# @FUNCTION: _at_uses_pkg
# @USAGE: <macros>
# @INTERNAL
# @DESCRIPTION:
# See if the specified macros are enabled.
_at_uses_pkg() {
	if [[ -n $(autotools_check_macro "$@") ]] ; then
		return 0
	else
		# If the trace didn't find it (perhaps because aclocal.m4 hasn't
		# been generated yet), cheat, but be conservative.
		local macro args=()
		for macro ; do
			args+=( -e "^[[:space:]]*${macro}\>" )
		done
		grep -E -q "${args[@]}" configure.??
	fi
}
_at_uses_autoheader()  { _at_uses_pkg A{C,M}_CONFIG_HEADER{S,}; }
_at_uses_automake()    { _at_uses_pkg AM_INIT_AUTOMAKE; }
_at_uses_gettext()     { _at_uses_pkg AM_GNU_GETTEXT_{,REQUIRE_}VERSION; }
_at_uses_glibgettext() { _at_uses_pkg AM_GLIB_GNU_GETTEXT; }
_at_uses_intltool()    { _at_uses_pkg {AC,IT}_PROG_INTLTOOL; }
_at_uses_gtkdoc()      { _at_uses_pkg GTK_DOC_CHECK; }
_at_uses_gnomedoc()    { _at_uses_pkg GNOME_DOC_INIT; }
_at_uses_libtool()     { _at_uses_pkg A{C,M}_PROG_LIBTOOL LT_INIT; }
_at_uses_libltdl()     { _at_uses_pkg LT_CONFIG_LTDL_DIR; }

# @FUNCTION: eaclocal_amflags
# @DESCRIPTION:
# Extract the ACLOCAL_AMFLAGS value from the Makefile.am and try to handle
# (most) of the crazy crap that people throw at us.
eaclocal_amflags() {
	local aclocal_opts amflags_file

	for amflags_file in GNUmakefile.am Makefile.am GNUmakefile.in Makefile.in ; do
		[[ -e ${amflags_file} ]] || continue
		# setup the env in case the pkg does something crazy
		# in their ACLOCAL_AMFLAGS.  like run a shell script
		# which turns around and runs autotools (bug #365401)
		# or split across multiple lines (bug #383525)
		aclocal_opts=$(sed -n \
			"/^ACLOCAL_AMFLAGS[[:space:]]*=/{ \
			  # match the first line
			  s:[^=]*=::p; \
			  # then gobble up all escaped lines
			  : nextline /\\\\$/{ n; p; b nextline; } \
			}" ${amflags_file})
		eval aclocal_opts=\""${aclocal_opts}"\"
		break
	done

	echo ${aclocal_opts}
}

# @FUNCTION: eaclocal
# @DESCRIPTION:
# These functions runs the autotools using autotools_run_tool with the
# specified parameters. The name of the tool run is the same of the function
# without e prefix.
# They also force installing the support files for safety.
# Respects AT_M4DIR for additional directories to search for macros.
eaclocal() {
	# Feed in a list of paths:
	# - ${BROOT}/usr/share/aclocal
	# - ${ESYSROOT}/usr/share/aclocal
	# See bug #677002
	if [[ ! -f "${T}"/aclocal/dirlist ]] ; then
		mkdir "${T}"/aclocal || die
		cat <<- EOF > "${T}"/aclocal/dirlist || die
			${BROOT}/usr/share/aclocal
			${ESYSROOT}/usr/share/aclocal
		EOF
	fi

	[[ ! -f aclocal.m4 || -n $(grep -e 'generated.*by aclocal' aclocal.m4) ]] && \
		autotools_run_tool --at-m4flags aclocal "$@" $(eaclocal_amflags) --system-acdir="${T}"/aclocal
}

# @FUNCTION: _elibtoolize
# @DESCRIPTION:
# Runs libtoolize.
#
# Note the '_' prefix: avoid collision with elibtoolize() from libtool.eclass.
_elibtoolize() {
	local LIBTOOLIZE=${LIBTOOLIZE:-$(type -P glibtoolize > /dev/null && echo glibtoolize || echo libtoolize)}

	if [[ ${1} == "--auto-ltdl" ]] ; then
		shift
		_at_uses_libltdl && set -- "$@" --ltdl
	fi

	[[ -f GNUmakefile.am || -f Makefile.am ]] && set -- "$@" --automake

	autotools_run_tool ${LIBTOOLIZE} "$@"
}

# @FUNCTION: eautoheader
# @DESCRIPTION:
# Runs autoheader.
eautoheader() {
	_at_uses_autoheader || return 0
	autotools_run_tool --at-no-fail --at-m4flags autoheader "$@"
}

# @FUNCTION: eautoconf
# @DESCRIPTION:
# Runs autoconf.
eautoconf() {
	if [[ ! -f configure.ac && ! -f configure.in ]] ; then
		echo
		eerror "No configure.{ac,in} present in '${PWD}'!"
		echo
		die "No configure.{ac,in} present!"
	fi

	if [[ -e configure.in ]] ; then
		mv configure.{in,ac} || die
	fi

	# Install config.guess and config.sub which are required by many macros
	# in autoconf >=2.70.
	local _gnuconfig=$(gnuconfig_findnewest)
	cp "${_gnuconfig}"/config.{guess,sub} . || die

	autotools_run_tool --at-m4flags autoconf "$@"
}

# @FUNCTION: eautomake
# @DESCRIPTION:
# Runs automake.
eautomake() {
	local extra_opts=()
	local makefile_name

	# Run automake if:
	#  - a Makefile.am type file exists
	#  - the configure script is using the AM_INIT_AUTOMAKE directive
	for makefile_name in {GNUmakefile,{M,m}akefile}.am "" ; do
		[[ -f ${makefile_name} ]] && break
	done

	_automake_version() {
		autotools_run_tool --at-output automake --version 2>/dev/null |
			sed -n -e '1{s:.*(GNU automake) ::p;q}'
	}

	if [[ -z ${makefile_name} ]] ; then
		_at_uses_automake || return 0

	elif [[ -z ${FROM_EAUTORECONF} && -f ${makefile_name%.am}.in ]] ; then
		eautoreconf
	fi

	[[ -f INSTALL && -f AUTHORS && -f ChangeLog && -f NEWS && -f README ]] \
		|| extra_opts+=( --foreign )

	# Older versions of automake do not support --force-missing.  But we want
	# to use this whenever possible to update random bundled files, bug #133489.
	case $(_automake_version) in
		1.4|1.4[.-]*) ;;
		*) extra_opts+=( --force-missing ) ;;
	esac

	autotools_run_tool automake --add-missing --copy "${extra_opts[@]}" "$@"
}

# @FUNCTION: eautopoint
# @DESCRIPTION:
# Runs autopoint (from the gettext package).
eautopoint() {
	autotools_run_tool autopoint "$@"
}

# @FUNCTION: config_rpath_update
# @USAGE: [destination]
# @DESCRIPTION:
# Some packages utilize the config.rpath helper script, but don't
# use gettext directly.  So we have to copy it in manually since
# we can't let `autopoint` do it for us.
config_rpath_update() {
	local src="${BROOT}/usr/share/gettext/config.rpath"

	[[ $# -eq 0 ]] && set -- $(find -name config.rpath)
	[[ $# -eq 0 ]] && return 0

	einfo "Updating all config.rpath files"
	local dst
	for dst in "$@" ; do
		einfo "   ${dst}"
		cp "${src}" "${dst}" || die
	done
}

# @FUNCTION: autotools_run_tool
# @USAGE: [--at-no-fail] [--at-m4flags] [--at-missing] [--at-output] <autotool> [tool-specific flags]
# @INTERNAL
# @DESCRIPTION:
# Run the specified autotool helper, but do logging and error checking
# around it in the process.
autotools_run_tool() {
	# Process our own internal flags first
	local autofail=true m4flags=false missing_ok=false return_output=false
	while [[ -n ${1} ]] ; do
		case ${1} in
			--at-no-fail) autofail=false ;;
			--at-m4flags) m4flags=true ;;
			--at-missing) missing_ok=true ;;
			--at-output)  return_output=true ;;
			# whatever is left goes to the actual tool
			*) break ;;
		esac
		shift
	done

	if [[ ${EBUILD_PHASE_FUNC} != "src_prepare" ]] ; then
		eqawarn "Running '${1}' in ${EBUILD_PHASE_FUNC} phase"
	fi

	if ${missing_ok} && ! type -P ${1} >/dev/null ; then
		einfo "Skipping '$*' because '${1}' not installed"
		return 0
	fi

	# Allow people to pass in full paths, bug #549268
	local STDERR_TARGET="${T}/${1##*/}.out"
	# most of the time, there will only be one run, but if there are
	# more, make sure we get unique log filenames
	if [[ -e ${STDERR_TARGET} ]] ; then
		local i=1
		while :; do
			STDERR_TARGET="${T}/${1##*/}-${i}.out"
			[[ -e ${STDERR_TARGET} ]] || break
			: $(( i++ ))
		done
	fi

	if ${m4flags} ; then
		set -- "${1}" $(autotools_m4dir_include) $(autotools_m4sysdir_include) "${@:2}"
	fi

	# If the caller wants to probe something, then let them do it directly.
	if ${return_output} ; then
		"$@"
		return
	fi

	printf "***** ${1} *****\n***** PWD: ${PWD}\n***** $*\n\n" > "${STDERR_TARGET}"

	ebegin "Running '$@'"
	"$@" >> "${STDERR_TARGET}" 2>&1
	if ! eend $? && ${autofail} ; then
		echo
		eerror "Failed running '${1}'!"
		eerror
		eerror "Include in your bug report the contents of:"
		eerror
		eerror "  ${STDERR_TARGET}"
		echo
		die "Failed running '${1}'!"
	fi
}

# Internal function to check for support

# Keep a list of all the macros we might use so that we only
# have to run the trace code once.  Order doesn't matter.
ALL_AUTOTOOLS_MACROS=(
	A{C,M}_PROG_LIBTOOL LT_INIT LT_CONFIG_LTDL_DIR
	A{C,M}_CONFIG_HEADER{S,}
	AC_CONFIG_SUBDIRS
	AC_CONFIG_AUX_DIR AC_CONFIG_MACRO_DIR
	AM_INIT_AUTOMAKE
	AM_GLIB_GNU_GETTEXT
	AM_GNU_GETTEXT_{,REQUIRE_}VERSION
	{AC,IT}_PROG_INTLTOOL
	GTK_DOC_CHECK
	GNOME_DOC_INIT
)
autotools_check_macro() {
	[[ -f configure.ac || -f configure.in ]] || return 0

	# We can run in multiple dirs, so we have to cache the trace
	# data in $PWD rather than an env var.
	local trace_file=".__autoconf_trace_data"
	if [[ ! -e ${trace_file} ]] || [[ ! aclocal.m4 -ot ${trace_file} ]] ; then
		autoconf \
			$(autotools_m4dir_include) \
			${ALL_AUTOTOOLS_MACROS[@]/#/--trace=} > ${trace_file} 2>/dev/null
	fi

	local macro args=()
	for macro ; do
		has ${macro} ${ALL_AUTOTOOLS_MACROS[@]} || die "internal error: add ${macro} to ALL_AUTOTOOLS_MACROS"
		args+=( -e ":${macro}:" )
	done
	grep "${args[@]}" ${trace_file}
}

# @FUNCTION: autotools_check_macro_val
# @USAGE: <macro> [macros]
# @INTERNAL
# @DESCRIPTION:
# Look for a macro and extract its value.
autotools_check_macro_val() {
	local macro scan_out

	for macro ; do
		autotools_check_macro "${macro}" | \
			gawk -v macro="${macro}" \
				'($0 !~ /^[[:space:]]*(#|dnl)/) {
					if (match($0, macro ":(.*)$", res))
						print res[1]
				}' | uniq
	done

	return 0
}

_autotools_m4dir_include() {
	local x include_opts flag

	for x in "$@" ; do
		case ${x} in
			# We handle it below
			-${flag}) ;;
			*)
				[[ ! -d ${x} ]] && ewarn "${ECLASS}: '${x}' does not exist"
				include_opts+=" -${flag} ${x}"
				;;
		esac
	done

	echo ${include_opts}
}
autotools_m4dir_include()    { _autotools_m4dir_include ${AT_M4DIR} ; }
autotools_m4sysdir_include() {
	# First try to use the paths the system integrator has set up.
	local paths=( $(eval echo ${AT_SYS_M4DIR}) )

	_autotools_m4dir_include "${paths[@]}"
}

fi

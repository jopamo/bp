# @ECLASS: autotools.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Regenerates auto* build scripts
# @DESCRIPTION:
# This eclass is for safely handling autotooled software packages that need to
# regenerate their build scripts.

if [[ ${_AUTOTOOLS_AUTO_DEPEND+set} == "set" ]] ; then
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
	AUTOTOOLS_DEPEND="
		${GNUCONFIG_DEPEND}
		${_automake_atom}
		${_autoconf_atom}
		${_libtool_atom}
	"
	RDEPEND=""

	# @ECLASS_VARIABLE: AUTOTOOLS_AUTO_DEPEND
	: "${AUTOTOOLS_AUTO_DEPEND:=yes}"
	[[ ${AUTOTOOLS_AUTO_DEPEND} != "no" ]] && BDEPEND=${AUTOTOOLS_DEPEND}
	_AUTOTOOLS_AUTO_DEPEND=${AUTOTOOLS_AUTO_DEPEND}

	unset _automake_atom _autoconf_atom

	: "${AM_OPTS:=}"
	: "${AT_NOEAUTOHEADER:=}"
	: "${AT_NOEAUTOMAKE:=}"
	: "${AT_NOELIBTOOLIZE:=}"
	: "${AT_M4DIR:=}"
	: "${AT_SYS_M4DIR:=}"

	eautoreconf() {
		local m4dir="${PWD}/m4"
		mkdir -p "${m4dir}"

		if [[ -d /usr/share/gettext/m4 ]]; then
			cp /usr/share/gettext/m4/lib*.m4 "${m4dir}/" || die "Failed to copy m4"
		else
			ewarn "m4 not found in /usr/share/gettext/m4/"
		fi

		local x
		if [[ -z ${AT_NO_RECURSIVE} ]] ; then
			for x in $(autotools_check_macro_val AC_CONFIG_SUBDIRS) ; do
				if [[ -d ${x} ]] ; then
					pushd "${x}" >/dev/null || die
					AT_NOELIBTOOLIZE="yes" eautoreconf || die
					popd >/dev/null || die
				fi
			done
		fi

		einfo "Running eautoreconf in '${PWD}' ..."
		local m4dirs
		m4dirs=$(autotools_check_macro_val AC_CONFIG_{AUX,MACRO}_DIR)
		[[ -n ${m4dirs} ]] && mkdir -p ${m4dirs}

		local i tools=(
			glibgettext false "autotools_run_tool glib-gettextize --copy --force"
			gettext     false "autotools_run_tool --at-missing autopoint --force"
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

		local rerun_aclocal=false
		eaclocal

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
			elibtoolize --force "${PWD}"
		fi
	}

	# Internal detection helpers
	_at_uses_pkg() {
		if [[ -n $(autotools_check_macro "$@") ]] ; then
			return 0
		else
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

	# Run aclocal with AM flags (autodetect)
	eaclocal_amflags() {
		local aclocal_opts amflags_file
		for amflags_file in GNUmakefile.am Makefile.am GNUmakefile.in Makefile.in ; do
			[[ -e ${amflags_file} ]] || continue
			aclocal_opts=$(sed -n \
				"/^ACLOCAL_AMFLAGS[[:space:]]*=/{
				  s:[^=]*=::p
				  : nextline
				  /\\\\$/{
				    n
				    p
				    b nextline
				  }
				}" ${amflags_file})
			eval aclocal_opts=\""${aclocal_opts}"\"
			break
		done
		echo ${aclocal_opts}
	}

	eaclocal() {
		if [[ ! -f "${T}"/aclocal/dirlist ]] ; then
			mkdir -p "${T}"/aclocal || die
			cat <<- EOF > "${T}"/aclocal/dirlist || die
				${BROOT}/usr/share/aclocal
				${ESYSROOT}/usr/share/aclocal
			EOF
		fi
		if [[ ! -f aclocal.m4 || -n $(grep -m1 -e 'generated.*by aclocal' aclocal.m4) ]]; then
			autotools_run_tool --at-m4flags aclocal "$@" $(eaclocal_amflags) \
				--system-acdir="${T}"/aclocal
		fi
	}

	_elibtoolize() {
		local LIBTOOLIZE=${LIBTOOLIZE:-$(type -P glibtoolize > /dev/null && echo glibtoolize || echo libtoolize)}
		if [[ $1 == "--auto-ltdl" ]]; then
			shift
			_at_uses_libltdl && set -- "$@" --ltdl
		fi
		[[ -f GNUmakefile.am || -f Makefile.am ]] && set -- "$@" --automake
		autotools_run_tool ${LIBTOOLIZE} "$@"
	}

	eautoheader() {
		_at_uses_autoheader || return 0
		autotools_run_tool --at-no-fail --at-m4flags autoheader "$@"
	}

	eautoconf() {
		if [[ ! -f configure.ac && ! -f configure.in ]] ; then
			eerror "No configure.{ac,in} present in '${PWD}'!"
			die "No configure.{ac,in} present!"
		fi
		if [[ -e configure.in ]] ; then
			mv configure.{in,ac} || die
		fi
		local _gnuconfig
		_gnuconfig=$(gnuconfig_findnewest)
		cp "${_gnuconfig}"/config.{guess,sub} . || die
		autotools_run_tool --at-m4flags autoconf "$@"
	}

	eautomake() {
		local extra_opts=()
		local makefile_name
		for makefile_name in {GNUmakefile,{M,m}akefile}.am "" ; do
			[[ -f ${makefile_name} ]] && break
		done

		_automake_version() {
			autotools_run_tool --at-output automake --version 2>/dev/null \
				| sed -n -e '1{s:.*(GNU automake) ::p;q}'
		}

		if [[ -z ${makefile_name} ]]; then
			_at_uses_automake || return 0
		elif [[ -z ${FROM_EAUTORECONF} && -f ${makefile_name%.am}.in ]]; then
			eautoreconf
		fi

		if [[ ! -f INSTALL || ! -f AUTHORS || ! -f ChangeLog || ! -f NEWS || ! -f README ]]; then
			extra_opts+=( --foreign )
		fi

		case $(_automake_version) in
			1.4|1.4[.-]*) ;;
			*) extra_opts+=( --force-missing ) ;;
		esac

		autotools_run_tool automake --add-missing --copy "${extra_opts[@]}" "$@"
	}

	eautopoint() {
		autotools_run_tool autopoint "$@"
	}

	config_rpath_update() {
		local src="${BROOT}/usr/share/gettext/config.rpath"
		[[ $# -eq 0 ]] && set -- $(find . -name config.rpath)
		[[ $# -eq 0 ]] && return 0
		einfo "Updating all config.rpath files"
		local dst
		for dst in "$@" ; do
			einfo "   ${dst}"
			cp "${src}" "${dst}" || die
		done
	}

	# Core runner for autotools-related commands
	autotools_run_tool() {
		local autofail=true m4flags=false missing_ok=false return_output=false
		while [[ -n ${1} ]]; do
			case ${1} in
				--at-no-fail)  autofail=false ;;
				--at-m4flags)  m4flags=true ;;
				--at-missing)  missing_ok=true ;;
				--at-output)   return_output=true ;;
				*) break ;;
			esac
			shift
		done

		if [[ ${EBUILD_PHASE_FUNC} != "src_prepare" ]]; then
			eqawarn "Running '${1}' in ${EBUILD_PHASE_FUNC} phase"
		fi
		if ${missing_ok} && ! type -P "${1}" &>/dev/null; then
			einfo "Skipping '$*' because '${1}' is not installed"
			return 0
		fi

		local STDERR_TARGET="${T}/${1##*/}.out"
		if [[ -e ${STDERR_TARGET} ]]; then
			local i=1
			while :; do
				STDERR_TARGET="${T}/${1##*/}-${i}.out"
				[[ -e ${STDERR_TARGET} ]] || break
				(( i++ ))
			done
		fi

		if ${m4flags}; then
			set -- "${1}" $(autotools_m4dir_include) $(autotools_m4sysdir_include) "${@:2}"
		fi

		if ${return_output}; then
			"$@"
			return
		fi

		printf "***** %s *****\n***** PWD: %s\n***** %s\n\n" \
			"${1}" "${PWD}" "$*" > "${STDERR_TARGET}"

		ebegin "Running '$*'"
		"$@" >> "${STDERR_TARGET}" 2>&1
		local ret=$?
		if ! eend ${ret} && ${autofail}; then
			eerror "Failed running '${1}'!"
			eerror "Include in your bug report:"
			eerror "  ${STDERR_TARGET}"
			die "Failed running '${1}'!"
		fi
	}

	ALL_AUTOTOOLS_MACROS=(
		A{C,M}_PROG_LIBTOOL LT_INIT LT_CONFIG_LTDL_DIR
		A{C,M}_CONFIG_HEADER{S,}
		AC_CONFIG_SUBDIRS
		AC_CONFIG_AUX_DIR
		AC_CONFIG_MACRO_DIR
		AM_INIT_AUTOMAKE
		AM_GLIB_GNU_GETTEXT
		AM_GNU_GETTEXT_{,REQUIRE_}VERSION
		{AC,IT}_PROG_INTLTOOL
		GTK_DOC_CHECK
		GNOME_DOC_INIT
	)

	autotools_check_macro() {
		[[ -f configure.ac || -f configure.in ]] || return 0
		local trace_file=".__autoconf_trace_data"
		if [[ ! -e ${trace_file} ]] || [[ ! aclocal.m4 -ot ${trace_file} ]]; then
			autoconf \
				$(autotools_m4dir_include) \
				${ALL_AUTOTOOLS_MACROS[@]/#/--trace=} > "${trace_file}" 2>/dev/null
		fi

		local macro args=()
		for macro; do
			has "${macro}" "${ALL_AUTOTOOLS_MACROS[@]}" || die "internal error: add ${macro} to ALL_AUTOTOOLS_MACROS"
			args+=( -e ":${macro}:" )
		done
		grep "${args[@]}" "${trace_file}"
	}

	autotools_check_macro_val() {
		local macro
		for macro; do
			autotools_check_macro "${macro}" \
				| gawk -v macro="${macro}" '
					($0 !~ /^[[:space:]]*(#|dnl)/) {
						if (match($0, macro ":(.*)$", arr))
							print arr[1]
					}
				' | uniq
		done
	}

	_autotools_m4dir_include() {
		local x include_opts
		local flag="I"
		for x in "$@"; do
			case ${x} in
				-"${flag}") ;;
				*)
					[[ ! -d ${x} ]] && ewarn "${ECLASS}: '${x}' does not exist"
					include_opts+=" -${flag} ${x}"
					;;
			esac
		done
		echo ${include_opts}
	}
	autotools_m4dir_include()    { _autotools_m4dir_include ${AT_M4DIR}; }
	autotools_m4sysdir_include() {
		local paths=( $(eval echo ${AT_SYS_M4DIR}) )
		_autotools_m4dir_include "${paths[@]}"
	}

fi

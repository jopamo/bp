#!/bin/bash
# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

__eapi7_ver_parse_range() {
	local range=${1}
	local max=${2}

	[[ ${range} == [0-9]* ]] \
		|| die "${FUNCNAME}: range must start with a number"
	start=${range%-*}
	[[ ${range} == *-* ]] && end=${range#*-} || end=${start}
	if [[ ${end} ]]; then
		[[ ${start} -le ${end} ]] \
			|| die "${FUNCNAME}: end of range must be >= start"
		[[ ${end} -le ${max} ]] || end=${max}
	else
		end=${max}
	fi
}

__eapi7_ver_split() {
	local v=${1} LC_ALL=C

	comp=()

	# get separators and components
	local s c
	while [[ ${v} ]]; do
		# cut the separator
		s=${v%%[a-zA-Z0-9]*}
		v=${v:${#s}}
		# cut the next component; it can be either digits or letters
		[[ ${v} == [0-9]* ]] && c=${v%%[^0-9]*} || c=${v%%[^a-zA-Z]*}
		v=${v:${#c}}

		comp+=( "${s}" "${c}" )
	done
}

ver_cut() {
	local range=${1}
	local v=${2:-${PV}}
	local start end
	local -a comp

	__eapi7_ver_split "${v}"
	local max=$((${#comp[@]}/2))
	__eapi7_ver_parse_range "${range}" "${max}"

	local IFS=
	if [[ ${start} -gt 0 ]]; then
		start=$(( start*2 - 1 ))
	fi
	echo "${comp[*]:start:end*2-start}"
}

ver_rs() {
	local v
	(( ${#} & 1 )) && v=${@: -1} || v=${PV}
	local start end i
	local -a comp

	__eapi7_ver_split "${v}"
	local max=$((${#comp[@]}/2 - 1))

	while [[ ${#} -ge 2 ]]; do
		__eapi7_ver_parse_range "${1}" "${max}"
		for (( i = start*2; i <= end*2; i+=2 )); do
			[[ ${i} -eq 0 && -z ${comp[i]} ]] && continue
			comp[i]=${2}
		done
		shift 2
	done

	local IFS=
	echo "${comp[*]}"
}

__eapi7_ver_compare_int() {
	local a=$1 b=$2 d=$(( ${#1}-${#2} ))

	# Zero-pad to equal length if necessary.
	if [[ ${d} -gt 0 ]]; then
		printf -v b "%0${d}d%s" 0 "${b}"
	elif [[ ${d} -lt 0 ]]; then
		printf -v a "%0$(( -d ))d%s" 0 "${a}"
	fi

	[[ ${a} > ${b} ]] && return 3
	[[ ${a} == "${b}" ]]
}

__eapi7_ver_compare() {
	local va=${1} vb=${2} a an al as ar b bn bl bs br re LC_ALL=C

	re="^([0-9]+(\.[0-9]+)*)([a-z]?)((_(alpha|beta|pre|rc|p)[0-9]*)*)(-r[0-9]+)?$"

	[[ ${va} =~ ${re} ]] || die "${FUNCNAME}: invalid version: ${va}"
	an=${BASH_REMATCH[1]}
	al=${BASH_REMATCH[3]}
	as=${BASH_REMATCH[4]}
	ar=${BASH_REMATCH[7]}

	[[ ${vb} =~ ${re} ]] || die "${FUNCNAME}: invalid version: ${vb}"
	bn=${BASH_REMATCH[1]}
	bl=${BASH_REMATCH[3]}
	bs=${BASH_REMATCH[4]}
	br=${BASH_REMATCH[7]}

	# Compare numeric components (PMS algorithm 3.2)
	# First component
	__eapi7_ver_compare_int "${an%%.*}" "${bn%%.*}" || return

	while [[ ${an} == *.* && ${bn} == *.* ]]; do
		# Other components (PMS algorithm 3.3)
		an=${an#*.}
		bn=${bn#*.}
		a=${an%%.*}
		b=${bn%%.*}
		if [[ ${a} == 0* || ${b} == 0* ]]; then
			# Remove any trailing zeros
			[[ ${a} =~ 0+$ ]] && a=${a%"${BASH_REMATCH[0]}"}
			[[ ${b} =~ 0+$ ]] && b=${b%"${BASH_REMATCH[0]}"}
			[[ ${a} > ${b} ]] && return 3
			[[ ${a} < ${b} ]] && return 1
		else
			__eapi7_ver_compare_int "${a}" "${b}" || return
		fi
	done
	[[ ${an} == *.* ]] && return 3
	[[ ${bn} == *.* ]] && return 1

	# Compare letter components (PMS algorithm 3.4)
	[[ ${al} > ${bl} ]] && return 3
	[[ ${al} < ${bl} ]] && return 1

	# Compare suffixes (PMS algorithm 3.5)
	as=${as#_}${as:+_}
	bs=${bs#_}${bs:+_}
	while [[ -n ${as} && -n ${bs} ]]; do
		# Compare each suffix (PMS algorithm 3.6)
		a=${as%%_*}
		b=${bs%%_*}
		if [[ ${a%%[0-9]*} == "${b%%[0-9]*}" ]]; then
			__eapi7_ver_compare_int "${a##*[a-z]}" "${b##*[a-z]}" || return
		else
			# Check for p first
			[[ ${a%%[0-9]*} == p ]] && return 3
			[[ ${b%%[0-9]*} == p ]] && return 1
			# Hack: Use that alpha < beta < pre < rc alphabetically
			[[ ${a} > ${b} ]] && return 3 || return 1
		fi
		as=${as#*_}
		bs=${bs#*_}
	done
	if [[ -n ${as} ]]; then
		[[ ${as} == p[_0-9]* ]] && return 3 || return 1
	elif [[ -n ${bs} ]]; then
		[[ ${bs} == p[_0-9]* ]] && return 1 || return 3
	fi

	# Compare revision components (PMS algorithm 3.7)
	__eapi7_ver_compare_int "${ar#-r}" "${br#-r}" || return

	return 2
}

ver_test() {
	local va op vb

	if [[ $# -eq 3 ]]; then
		va=${1}
		shift
	else
		va=${PVR}
	fi

	[[ $# -eq 2 ]] || die "${FUNCNAME}: bad number of arguments"

	op=${1}
	vb=${2}

	case ${op} in
		-eq|-ne|-lt|-le|-gt|-ge) ;;
		*) die "${FUNCNAME}: invalid operator: ${op}" ;;
	esac

	__eapi7_ver_compare "${va}" "${vb}"
	test $? "${op}" 2
}

strip-linguas() {
	local ls newls nols
	if [[ $1 == "-i" ]] || [[ $1 == "-u" ]] ; then
		local op=$1; shift
		ls=$(find "$1" -name '*.po' -exec basename {} .po ';'); shift
		local d f
		for d in "$@" ; do
			if [[ ${op} == "-u" ]] ; then
				newls=${ls}
			else
				newls=""
			fi
			for f in $(find "$d" -name '*.po' -exec basename {} .po ';') ; do
				if [[ ${op} == "-i" ]] ; then
					has ${f} ${ls} && newls="${newls} ${f}"
				else
					has ${f} ${ls} || newls="${newls} ${f}"
				fi
			done
			ls=${newls}
		done
	else
		ls="$@"
	fi

	nols=""
	newls=""
	for f in ${LINGUAS} ; do
		if has ${f} ${ls} ; then
			newls="${newls} ${f}"
		else
			nols="${nols} ${f}"
		fi
	done
	[[ -n ${nols} ]] \
		&& einfo "Sorry, but ${PN} does not support the LINGUAS:" ${nols}
	export LINGUAS=${newls:1}
}

# @FUNCTION: cleanup_install
# @DESCRIPTION:
# Minimize the installed files
cleanup_install() {
	find "${D}" -name '*.la' -delete || die
	rm -rf "${ED}"/usr/share/{bash-completion,doc,zsh}
	rm -rf "${ED}"/usr/share/man/{ca,de*,es,fr*,it,ja*,man{3,5,7,n},pl,pt,pt_BR,ru*,uk,zh_CHS}
	rm -rf "${ED}"/usr/share/locale/{a*,b*,c*,d*,el,en_CA,en_GB,eo,es*,et,eu,f*,g*,h*,i*,j*,k*,lg,li,lt,lv,m*,n*,o*,p*,q*,r*,s*,t*,u*,v*,w*,x*,y*,z*}
	rm -rf "${ED}"/usr/share/i18n/locales/{a*,b*,c*,d*,e{l,o,s,t,u}*,f*,g*,h*,i{a,d,g,k,t,u}*,j*,k*,l*,m*,n*,o*,p*,q*,r*,s*,t{a,c,e,g,h,i,k,l,n,o,p}*,u*,v*,w*,x*,y*,z*}
}

# @FUNCTION: xdg_environment_reset
# @DESCRIPTION:
# Clean up environment for clean builds.
xdg_environment_reset() {
	# Prepare XDG base directories
	export XDG_DATA_HOME="${HOME}/.local/share"
	export XDG_CONFIG_HOME="${HOME}/.config"
	export XDG_CACHE_HOME="${HOME}/.cache"
	export XDG_RUNTIME_DIR="${T}/run"
	mkdir -p "${XDG_DATA_HOME}" "${XDG_CONFIG_HOME}" "${XDG_CACHE_HOME}" \
		"${XDG_RUNTIME_DIR}" || die
	# This directory needs to be owned by the user, and chmod 0700
	# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
	chmod 0700 "${XDG_RUNTIME_DIR}" || die

	unset DBUS_SESSION_BUS_ADDRESS
}

# @FUNCTION: eprefixify
# @USAGE: <list of to be eprefixified files>
# @DESCRIPTION:
# replaces @GENTOO_PORTAGE_EPREFIX@ with ${EPREFIX} for the given files,
# dies if no arguments are given, a file does not exist, or changing a
# file failed.
eprefixify() {
	[[ $# -lt 1 ]] && die "at least one argument required"

	einfo "Adjusting to prefix ${EPREFIX:-/}"
	local x
	for x in "$@" ; do
		if [[ -e ${x} ]] ; then
			ebegin "  ${x##*/}"
			sed -i -e "s|@GENTOO_PORTAGE_EPREFIX@|${EPREFIX}|g" "${x}"
			eend $? || die "failed to eprefixify ${x}"
		else
			die "${x} does not exist"
		fi
	done

	return 0
}

# @FUNCTION: hprefixify
# @USAGE: [ -w <line match> ] [ -e <extended regex> ] [ -q <quotation char> ] <list of files>
# @DESCRIPTION:
# Tries a set of heuristics to prefixify the given files. Dies if no
# arguments are given, a file does not exist, or changing a file failed.
#
# Additional extended regular expression can be passed by -e or
# environment variable PREFIX_EXTRA_REGEX.  The default heuristics can
# be constrained to lines that match a sed expression passed by -w or
# environment variable PREFIX_LINE_MATCH.  Quotation characters can be
# specified by -q or environment variable PREFIX_QUOTE_CHAR, unless
# EPREFIX is empty.
#
# @EXAMPLE:
# Only prefixify the 30th line,
#   hprefixify -w 30 configure
# Only prefixify lines that contain "PATH",
#   hprefixify -w "/PATH/" configure
# Also delete all the /opt/gnu search paths,
#   hprefixify -e "/\/opt\/gnu/d" configure
# Quote the inserted EPREFIX
#   hprefixify -q '"' etc/profile
hprefixify() {
	use prefix || return 0

	local xl=() x
	while [[ $# -gt 0 ]]; do
		case $1 in
			-e) local PREFIX_EXTRA_REGEX="$2"
				shift
				;;
			-w) local PREFIX_LINE_MATCH="$2"
				shift
				;;
			-q) local PREFIX_QUOTE_CHAR="${EPREFIX:+$2}"
				shift
				;;
			*)
				xl+=( "$1" )
				;;
		esac
		shift
	done
	local dirs="/(usr|lib(|[onx]?32|n?64)|etc|bin|sbin|var|opt|run)" \
		  eprefix="${PREFIX_QUOTE_CHAR}${EPREFIX}${PREFIX_QUOTE_CHAR}"

	[[ ${#xl[@]} -lt 1 ]] && die "at least one file operand is required"
	einfo "Adjusting to prefix ${EPREFIX:-/}"
	for x in "${xl[@]}" ; do
		if [[ -e ${x} ]] ; then
			ebegin "  ${x##*/}"
			sed -r \
				-e "${PREFIX_LINE_MATCH}s,([^[:alnum:]}\)\.])${dirs},\1${eprefix}/\2,g" \
				-e "${PREFIX_LINE_MATCH}s,^${dirs},${eprefix}/\1," \
				-e "${PREFIX_EXTRA_REGEX}" \
				-i "${x}"
			eend $? || die "failed to prefixify ${x}"
		else
			die "${x} does not exist"
		fi
	done
}

# @FUNCTION: get_libdir
# @RETURN: the libdir for the selected ABI
get_libdir() {
	get_abi_LIBDIR
}

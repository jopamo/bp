# Distributed under the terms of the GNU General Public License v2

# @ECLASS: pkgconfig-sanity.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Validation and cleanup helpers for pkg-config metadata
# @DESCRIPTION:
# Enforces build path hygiene and portability rules for installed .pc files

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_PKGCONFIG_SANITY_ECLASS} ]] ; then
_PKGCONFIG_SANITY_ECLASS=1

: "${PC_ALLOW:=}"
: "${PC_STRICT:=1}"
: "${PC_VALIDATE_STATIC:=0}"
: "${PC_FIX_NORMALIZE:=1}"
: "${PC_FAIL_OVERLINK:=0}"
: "${PC_SYSROOT_DIR:=}"

_pc-rule-allowed() {
	local rule=$1
	local rel=$2
	local token rule_part re

	for token in ${PC_ALLOW}; do
		if [[ ${token} == *:* ]]; then
			rule_part=${token%%:*}
			re=${token#*:}
			[[ ${rule} == "${rule_part}" && ${rel} =~ ${re} ]] && return 0
		else
			[[ ${rel} =~ ${token} ]] && return 0
		fi
	done

	return 1
}

_pc-find-files() {
	local input
	local -a files=()
	local -a found=()

	if [[ ${#} -eq 0 ]]; then
		if [[ -d ${ED}/usr ]]; then
			mapfile -d '' -t files < <(find -H "${ED}/usr" -type f -path '*/pkgconfig/*.pc' -print0)
		fi
		echo "${files[@]}"
		return
	fi

	for input in "$@" ; do
		[[ -e ${input} ]] || die "pc: missing path ${input}"
	done

	for input in "$@" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -name '*.pc' -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} && ${input} == *.pc ]]; then
			files+=( "${input}" )
		fi
	done

	echo "${files[@]}"
}

_pc-has-build-leak() {
	local file=$1
	grep -Eq '/var/tmp/|/tmp/portage/' "${file}" && return 0
	[[ -n ${WORKDIR} ]] && grep -Fq "${WORKDIR}" "${file}" && return 0
	[[ -n ${S} ]] && grep -Fq "${S}" "${file}" && return 0
	[[ -n ${D} ]] && grep -Fq "${D}" "${file}" && return 0
	[[ -n ${ED} ]] && grep -Fq "${ED}" "${file}" && return 0
	return 1
}

_pc-count-libs() {
	local line=$1
	local token count=0
	for token in ${line}; do
		[[ ${token} == -l* ]] && (( count += 1 ))
	done
	echo "${count}"
}

_pc-has-hardcoded-sysroot-hostile-path() {
	local file=$1
	grep -Eq '(^|[[:space:]])-L/usr/lib(64)?([[:space:]]|$)' "${file}" && return 0
	grep -Eq '(^|[[:space:]])-I/usr/include([[:space:]]|$)' "${file}" && return 0
	return 1
}

_pc-run-static-check() {
	local file=$1
	local module
	module=${file##*/}
	module=${module%.pc}

	command -v pkg-config >/dev/null || return 0

	local libdir=
	local d
	for d in "${ED}/usr/lib/pkgconfig" "${ED}/usr/lib64/pkgconfig" "${ED}/usr/share/pkgconfig"; do
		[[ -d ${d} ]] || continue
		if [[ -z ${libdir} ]]; then
			libdir=${d}
		else
			libdir=${libdir}:${d}
		fi
	done

	[[ -n ${libdir} ]] || return 0

	local sysroot=${PC_SYSROOT_DIR:-/}
	PKG_CONFIG_LIBDIR=${libdir} PKG_CONFIG_SYSROOT_DIR=${sysroot} pkg-config --exists --static "${module}" || return 1
	PKG_CONFIG_LIBDIR=${libdir} PKG_CONFIG_SYSROOT_DIR=${sysroot} pkg-config --libs --static "${module}" >/dev/null || return 1

	return 0
}

# @FUNCTION: pc-validate
# @USAGE: [path] [more]
# @DESCRIPTION:
# Scan pkg-config files for leak and policy violations
pc-validate() {
	local -a files=( $(_pc-find-files "$@") )
	[[ ${#files[@]} -gt 0 ]] || return 0

	local -i failures=0
	local file rel libs libs_private requires_private libs_count
	for file in "${files[@]}" ; do
		rel=${file#${ED}}

		if _pc-has-build-leak "${file}" && ! _pc-rule-allowed buildpath "${rel}"; then
			eerror "pc: build path leak in ${rel}"
			(( failures += 1 ))
		fi

		if _pc-has-hardcoded-sysroot-hostile-path "${file}" && ! _pc-rule-allowed sysroot "${rel}"; then
			eerror "pc: hardcoded host path in ${rel}"
			(( failures += 1 ))
		fi

		libs=$(sed -n 's/^Libs:[[:space:]]*//p' "${file}" | head -n1)
		libs_private=$(sed -n 's/^Libs.private:[[:space:]]*//p' "${file}" | head -n1)
		requires_private=$(sed -n 's/^Requires.private:[[:space:]]*//p' "${file}" | head -n1)
		libs_count=$(_pc-count-libs "${libs}")
		if [[ ${PC_FAIL_OVERLINK} == 1 && ${libs_count} -ge 2 && -z ${libs_private} && -z ${requires_private} ]] && ! _pc-rule-allowed overlink "${rel}"; then
			eerror "pc: likely overlinked Libs in ${rel}"
			(( failures += 1 ))
		fi

		if [[ ${PC_VALIDATE_STATIC} == 1 ]] && ! _pc-run-static-check "${file}" && ! _pc-rule-allowed static "${rel}"; then
			eerror "pc: pkg-config --static validation failed for ${rel}"
			(( failures += 1 ))
		fi
	done

	[[ ${failures} -eq 0 ]]
}

_pc-fix-generic-leaks() {
	local file=$1
	sed -i -E 's#(/var/tmp/portage|/tmp/portage|/var/tmp)/[^[:space:]]+##g' "${file}" || die "pc: failed to strip generic build paths from ${file}"
}

_pc-escape-regex() {
	printf '%s' "$1" | sed -e 's/[.[\*^$()+?{}|\/]/\\&/g'
}

_pc-fix-known-path() {
	local file=$1
	local path=$2
	[[ -n ${path} ]] || return

	local escaped
	escaped=$(_pc-escape-regex "${path}")
	sed -i -E "s#${escaped}[^[:space:]]*##g" "${file}" || die "pc: failed to strip ${path} from ${file}"
}

# @FUNCTION: pc-fixup
# @USAGE: [path] [more]
# @DESCRIPTION:
# Apply safe in-place cleanups to installed .pc files
pc-fixup() {
	local -a files=( $(_pc-find-files "$@") )
	[[ ${#files[@]} -gt 0 ]] || return

	local file
	for file in "${files[@]}" ; do
		_pc-fix-generic-leaks "${file}"
		_pc-fix-known-path "${file}" "${WORKDIR}"
		_pc-fix-known-path "${file}" "${S}"
		_pc-fix-known-path "${file}" "${D}"
		_pc-fix-known-path "${file}" "${ED}"

		if [[ ${PC_FIX_NORMALIZE} == 1 ]]; then
			sed -i -E 's/[[:space:]]+/ /g; s/[[:space:]]+$//' "${file}" || die "pc: failed to normalize ${file}"
		fi
	done
}

# @FUNCTION: pc-assert
# @USAGE: [path] [more]
# @DESCRIPTION:
# Enforce pkg-config policy and die in strict mode
pc-assert() {
	if ! pc-validate "$@"; then
		if [[ ${PC_STRICT} == 1 ]]; then
			die "pc-assert: pkg-config policy violations detected"
		fi
		ewarn "pc-assert: pkg-config policy violations detected"
	fi
}

fi

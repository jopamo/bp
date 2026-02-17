# Distributed under the terms of the GNU General Public License v2

# @ECLASS: binutils-sanitizer.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Archive level checks and fixups for installed static libs
# @DESCRIPTION:
# Detect thin archives, missing index state, and toolchain locked LTO payloads

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_BINUTILS_SANITIZER_ECLASS} ]] ; then
_BINUTILS_SANITIZER_ECLASS=1

inherit toolchain-funcs

: "${BU_FORBID_THIN:=1}"
: "${BU_REQUIRE_INDEX:=1}"
: "${BU_FORBID_LTO_IR_IN_BINPKG:=1}"
: "${BU_CONVERT_THIN:=1}"
: "${BU_REINDEX_ALL:=1}"
: "${BU_STRICT:=1}"
: "${BU_ALLOW:=}"

_bu-rule-allowed() {
	local rule=$1
	local rel=$2
	local token rule_part re

	for token in ${BU_ALLOW}; do
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

_bu-find-archives() {
	local input
	local -a files=()
	local -a found=()

	if [[ ${#} -eq 0 ]]; then
		set -- "${ED}"
	fi

	for input in "$@" ; do
		[[ -e ${input} ]] || die "bu: missing path ${input}"
	done

	for input in "$@" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f -name '*.a' -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} && ${input} == *.a ]]; then
			files+=( "${input}" )
		fi
	done

	echo "${files[@]}"
}

_bu-is-thin() {
	local archive=$1
	local magic
	magic=$(dd if="${archive}" bs=1 count=7 2>/dev/null || true)
	[[ ${magic} == '!<thin>' ]]
}

_bu-has-index() {
	local archive=$1
	local nm_cmd
	nm_cmd=$(tc-getNM)
	"${nm_cmd}" -s "${archive}" 2>/dev/null | grep -q '^Archive index:'
}

_bu-has-lto-ir() {
	local archive=$1
	grep -aEq '__gnu_lto_v1|\.gnu\.lto_|\.llvmbc|\.llvm' "${archive}"
}

_bu-building-binpkg() {
	[[ " ${FEATURES} " == *" buildpkg "* ]] || [[ " ${FEATURES} " == *" buildpkg-live "* ]] || [[ -n ${BINPKG_FORMAT} ]]
}

_bu-convert-thin() {
	local archive=$1
	local ar_cmd
	ar_cmd=$(tc-getAR)

	local tmpd tmpa
	tmpd=$(mktemp -d "${T}/bu-thin-XXXXXX") || die "bu: mktemp failed"
	tmpa=${archive}.tmp

	if ! ( cd "${tmpd}" && "${ar_cmd}" x "${archive}" ); then
		rm -rf "${tmpd}"
		if [[ ${BU_STRICT} == 1 ]]; then
			die "bu: unable to extract thin archive ${archive}"
		fi
		ewarn "bu: unable to extract thin archive ${archive}"
		return 1
	fi

	local -a members=()
	while IFS= read -r -d '' m; do
		members+=( "${m}" )
	done < <(find -H "${tmpd}" -maxdepth 1 -type f -print0)

	if [[ ${#members[@]} -eq 0 ]]; then
		rm -rf "${tmpd}"
		if [[ ${BU_STRICT} == 1 ]]; then
			die "bu: thin archive ${archive} had no extractable members"
		fi
		ewarn "bu: thin archive ${archive} had no extractable members"
		return 1
	fi

	"${ar_cmd}" crs "${tmpa}" "${members[@]}" || die "bu: unable to rebuild ${archive}"
	mv "${tmpa}" "${archive}" || die "bu: unable to replace ${archive}"
	rm -rf "${tmpd}"
}

# @FUNCTION: bu-archive-check
# @USAGE: [path] ...
# @DESCRIPTION:
# Classify installed archives and return non-zero on policy violations
bu-archive-check() {
	local -a archives=( $(_bu-find-archives "$@") )
	[[ ${#archives[@]} -gt 0 ]] || return 0

	local -i failures=0
	local archive rel thin indexed has_ir
	local binpkg=0
	_bu-building-binpkg && binpkg=1

	for archive in "${archives[@]}" ; do
		rel=${archive#${ED}}
		thin=0
		indexed=0
		has_ir=0

		_bu-is-thin "${archive}" && thin=1
		_bu-has-index "${archive}" && indexed=1
		_bu-has-lto-ir "${archive}" && has_ir=1

		einfo "bu: ${rel}: thin=${thin} indexed=${indexed} lto_ir=${has_ir}"

		if [[ ${BU_FORBID_THIN} == 1 && ${thin} == 1 ]] && ! _bu-rule-allowed thin "${rel}"; then
			eerror "bu: thin archive forbidden in ${rel}"
			(( failures += 1 ))
		fi

		if [[ ${BU_REQUIRE_INDEX} == 1 && ${indexed} == 0 ]] && ! _bu-rule-allowed index "${rel}"; then
			eerror "bu: archive index missing in ${rel}"
			(( failures += 1 ))
		fi

		if [[ ${BU_FORBID_LTO_IR_IN_BINPKG} == 1 && ${binpkg} == 1 && ${has_ir} == 1 ]] && ! _bu-rule-allowed lto_ir "${rel}"; then
			eerror "bu: LTO IR payload forbidden for binpkg in ${rel}"
			(( failures += 1 ))
		fi
	done

	[[ ${failures} -eq 0 ]]
}

# @FUNCTION: bu-archive-fixup
# @USAGE: [path] ...
# @DESCRIPTION:
# Reindex archives and optionally convert thin archives to normal archives
bu-archive-fixup() {
	local -a archives=( $(_bu-find-archives "$@") )
	[[ ${#archives[@]} -gt 0 ]] || return

	local ar_cmd ranlib_cmd
	ar_cmd=$(tc-getAR)
	ranlib_cmd=$(tc-getRANLIB)

	local archive rel thin
	for archive in "${archives[@]}" ; do
		rel=${archive#${ED}}
		thin=0
		_bu-is-thin "${archive}" && thin=1

		if [[ ${thin} == 1 && ${BU_CONVERT_THIN} == 1 ]]; then
			einfo "bu: converting thin archive ${rel}"
			_bu-convert-thin "${archive}"
			thin=0
		fi

		if [[ ${BU_REINDEX_ALL} == 1 || ${BU_REQUIRE_INDEX} == 1 ]]; then
			"${ar_cmd}" s "${archive}" >/dev/null 2>&1 || true
			"${ranlib_cmd}" "${archive}" || die "bu: ranlib failed for ${rel}"
		fi
	done
}

# @FUNCTION: bu-assert
# @USAGE: [path] ...
# @DESCRIPTION:
# Enforce archive policy on installed files
bu-assert() {
	bu-archive-check "$@" || die "bu-assert: archive policy violations detected"
}

fi

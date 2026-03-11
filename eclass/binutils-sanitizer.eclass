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
: "${BU_CHECK_LDSCRIPTS:=1}"
: "${BU_REQUIRE_GNU_LDSCRIPT_HEADER:=1}"
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

_bu-is-archive() {
	local archive=$1
	local magic
	magic=$(LC_ALL=C od -An -N8 -tx1 "${archive}" 2>/dev/null | tr -d ' \n')
	[[ ${magic} == 213c617263683e0a || ${magic} == 213c7468696e3e0a ]]
}

_bu-find-archives() {
	local input
	local file
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
			for file in "${found[@]}" ; do
				_bu-is-archive "${file}" && files+=( "${file}" )
			done
		elif [[ -f ${input} && ${input} == *.a ]] && _bu-is-archive "${input}"; then
			files+=( "${input}" )
		fi
	done

	if [[ ${#files[@]} -gt 0 ]]; then
		printf '%s\0' "${files[@]}"
	fi

	return 0
}

_bu-is-ldscript() {
	local file=$1
	local magic
	magic=$(dd if="${file}" bs=1 count=4 2>/dev/null || true)
	[[ ${magic} == $'\177ELF' ]] && return 1

	grep -aqE '^[[:space:]]*(/\* GNU ld script \*/)?[[:space:]]*(INPUT|GROUP)[[:space:]]*\(' "${file}"
}

_bu-find-ldscripts() {
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
			mapfile -d '' -t found < <(find -H "${input}" -type f -name '*.so' -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} && ${input} == *.so ]]; then
			files+=( "${input}" )
		fi
	done

	local script
	local -a scripts=()
	for script in "${files[@]}" ; do
		_bu-is-ldscript "${script}" && scripts+=( "${script}" )
	done

	if [[ ${#scripts[@]} -gt 0 ]]; then
		printf '%s\0' "${scripts[@]}"
	fi

	return 0
}

_bu-ldscript-has-header() {
	local file=$1
	head -n 1 "${file}" | grep -qE '^[[:space:]]*/\* GNU ld script([[:space:]]+\*/)?[[:space:]]*$'
}

_bu-ldscript-has-token() {
	local file=$1
	local token=$2
	local tok
	while read -r tok; do
		[[ ${tok} == "${token}" ]] && return 0
	done < <(tr '()\t\n' '    ' < "${file}")

	return 1
}

_bu-is-thin() {
	local archive=$1
	local magic
	magic=$(dd if="${archive}" bs=1 count=7 2>/dev/null || true)
	[[ ${magic} == '!<thin>' ]]
}

_bu-is-empty-archive() {
	local archive=$1
	local ar_cmd
	local listing

	ar_cmd=$(tc-getAR)
	listing=$("${ar_cmd}" t "${archive}" 2>/dev/null) || return 1
	[[ -z ${listing} ]]
}

_bu-has-index() {
	local archive=$1
	local nm_cmd
	local nm_out

	# Empty archives intentionally carry no symbol table. Treat them as
	# satisfying the index requirement so compatibility stubs such as glibc's
	# empty libpthread.a/libdl.a do not fail QA.
	_bu-is-empty-archive "${archive}" && return 0

	nm_cmd=$(tc-getNM)
	nm_out=$("${nm_cmd}" -s "${archive}" 2>/dev/null) || return 1
	grep -q '^Archive index:' <<< "${nm_out}"
}

	_bu-has-lto-ir() {
		local archive=$1
		grep -aEq '__gnu_lto_v1|\.gnu\.lto_|\.llvmbc|\.llvm\.lto' "${archive}"
	}

_bu-building-binpkg() {
	[[ " ${FEATURES} " == *" buildpkg "* ]] || [[ " ${FEATURES} " == *" buildpkg-live "* ]] || [[ -n ${BINPKG_FORMAT} ]]
}

_bu-convert-thin() {
	local archive=$1
	local ar_cmd
	ar_cmd=$(tc-getAR)

	local tmpd tmpa listing
	tmpd=$(mktemp -d "${T}/bu-thin-XXXXXX") || die "bu: mktemp failed"
	tmpa=${archive}.tmp

	if ! listing=$("${ar_cmd}" t "${archive}" 2>/dev/null); then
		rm -rf "${tmpd}"
		if [[ ${BU_STRICT} == 1 ]]; then
			die "bu: unable to read thin archive members from ${archive}"
		fi
		ewarn "bu: unable to read thin archive members from ${archive}"
		return 1
	fi

	local -a members=()
	local m
	while IFS= read -r m; do
		[[ -n ${m} ]] || continue
		members+=( "${m}" )
	done <<< "${listing}"

	if [[ ${#members[@]} -eq 0 ]]; then
		rm -rf "${tmpd}"
		if [[ ${BU_STRICT} == 1 ]]; then
			die "bu: thin archive ${archive} had no readable members"
		fi
		ewarn "bu: thin archive ${archive} had no readable members"
		return 1
	fi

	local -a copies=()
	local member_dir member_copy
	local -i idx=0

	# ar(1) rejects `x` on thin archives, so rebuild a normal archive from the
	# enumerated member payloads while preserving duplicate basenames.
	for m in "${members[@]}" ; do
		member_dir=${tmpd}/$(( ++idx ))
		member_copy=${member_dir}/${m##*/}
		mkdir -p "${member_dir}" || die "bu: unable to create ${member_dir}"
		if ! "${ar_cmd}" pP "${archive}" "${m}" > "${member_copy}"; then
			rm -rf "${tmpd}"
			if [[ ${BU_STRICT} == 1 ]]; then
				die "bu: unable to copy thin archive member ${m} from ${archive}"
			fi
			ewarn "bu: unable to copy thin archive member ${m} from ${archive}"
			return 1
		fi
		copies+=( "${member_copy}" )
	done

	"${ar_cmd}" crs "${tmpa}" "${copies[@]}" || die "bu: unable to rebuild ${archive}"
	mv "${tmpa}" "${archive}" || die "bu: unable to replace ${archive}"
	rm -rf "${tmpd}"
}

# @FUNCTION: bu-archive-check
# @USAGE: [path] ...
# @DESCRIPTION:
# Classify installed archives and return non-zero on policy violations
bu-archive-check() {
	local -a archives=()
	mapfile -d '' -t archives < <(_bu-find-archives "$@")
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

# @FUNCTION: bu-ldscript-check
# @USAGE: [path] ...
# @DESCRIPTION:
# Validate installed linker-script .so files and known dependency token sets
bu-ldscript-check() {
	local -a scripts=()
	mapfile -d '' -t scripts < <(_bu-find-ldscripts "$@")
	[[ ${#scripts[@]} -gt 0 ]] || return 0

	local -i failures=0
	local script rel dep
	for script in "${scripts[@]}" ; do
		rel=${script#${ED}}
		einfo "bu: ldscript ${rel}"

		if [[ ${BU_REQUIRE_GNU_LDSCRIPT_HEADER} == 1 ]] \
			&& ! _bu-ldscript-has-header "${script}" \
			&& ! _bu-rule-allowed ldscript_header "${rel}"; then
			eerror "bu: ldscript header missing in ${rel}"
			(( failures += 1 ))
		fi

		if [[ ${rel} == */libbfd.so ]]; then
			local -a required=( -liberty -lsframe -lz -lzstd -lstdc++ -ldl )
			for dep in "${required[@]}"; do
				if ! _bu-ldscript-has-token "${script}" "${dep}" \
					&& ! _bu-rule-allowed ldscript_dep "${rel}"; then
					eerror "bu: ${rel} missing required token ${dep}"
					(( failures += 1 ))
				fi
			done
		fi
	done

	[[ ${failures} -eq 0 ]]
}

# @FUNCTION: bu-archive-fixup
# @USAGE: [path] ...
# @DESCRIPTION:
# Reindex archives and optionally convert thin archives to normal archives
bu-archive-fixup() {
	local -a archives=()
	mapfile -d '' -t archives < <(_bu-find-archives "$@")
	[[ ${#archives[@]} -gt 0 ]] || return 0

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
	if [[ ${BU_CHECK_LDSCRIPTS} == 1 ]]; then
		bu-ldscript-check "$@" || die "bu-assert: ldscript policy violations detected"
	fi
}

fi

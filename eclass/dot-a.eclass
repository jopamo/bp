# Distributed under the terms of the GNU General Public License v2

# @ECLASS: dot-a.eclass
# @MAINTAINER:
# Toolchain Team
# @SUPPORTED_EAPIS: 8
# @BLURB: Helpers to strip LTO bytecode from static archives
# @DESCRIPTION:
# Call lto-guarantee-fat before configure and strip-lto-bytecode after install

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_DOT_A_ECLASS} ]] ; then
_DOT_A_ECLASS=1

inherit flag-o-matic toolchain-funcs

# @VARIABLE: _DOT_A_IS_LTO
# @INTERNAL
# @DESCRIPTION:
# Tracks whether tc-is-lto was true when lto-guarantee-fat was called
_DOT_A_IS_LTO=0

# @FUNCTION: _dot-a-get-strip-mode
# @INTERNAL
# @RETURN: Prints gnu for GCC, llvm for clang, nothing otherwise
_dot-a-get-strip-mode() {
	case $(tc-get-compiler-type) in
		gcc) echo gnu ;;
		clang) echo llvm ;;
		*) return 1 ;;
	esac
}

# @FUNCTION: lto-guarantee-fat
# @DESCRIPTION:
# Appends flags needed to emit fat objects when LTO is enabled
lto-guarantee-fat() {
	tc-is-lto || return

	_DOT_A_IS_LTO=1

	local -a fat_flags=( $(test-flags-CC -ffat-lto-objects) )
	[[ ${#fat_flags[@]} -gt 0 ]] && append-flags "${fat_flags[@]}"
}

# @FUNCTION: strip-lto-bytecode
# @USAGE: [library|directory] [...]
# @DESCRIPTION:
# Strips LTO bytecode from *.a and *.o inputs
# With no arguments it scans ${ED}, unless USE=static-libs is disabled
strip-lto-bytecode() {
	if [[ ${_DOT_A_IS_LTO} != 1 ]] && ! tc-is-lto; then
		return
	fi

	if [[ ${#} -eq 0 ]]; then
		if in_iuse static-libs && ! use static-libs ; then
			return
		fi
		set -- "${ED}"
	fi

	local input
	for input in "$@" ; do
		[[ -e ${input} ]] || die "strip-lto-bytecode: missing path: ${input}"
	done

	local -a files=()
	local -a found=()
	for input in "$@" ; do
		if [[ -d ${input} ]]; then
			mapfile -d '' -t found < <(find -H "${input}" -type f \( -name '*.a' -o -name '*.o' \) -print0)
			files+=( "${found[@]}" )
		elif [[ -f ${input} ]]; then
			case ${input} in
				*.a|*.o) files+=( "${input}" ) ;;
			esac
		fi
	done

	[[ ${#files[@]} -gt 0 ]] || return

	local strip_mode
	strip_mode=$(_dot-a-get-strip-mode) || return

	local file
	case ${strip_mode} in
		gnu)
			local -a strip_cmd=( $(tc-getSTRIP) )
			command -v "${strip_cmd[0]}" >/dev/null || die "strip-lto-bytecode: unable to find ${strip_cmd[0]}"
			for file in "${files[@]}" ; do
				"${strip_cmd[@]}" \
					-R .gnu.lto_* \
					-R .gnu.debuglto_* \
					-N __gnu_lto_v1 \
					"${file}" || die "Stripping bytecode in ${file} failed"
			done
			;;
		llvm)
			local -a llvm_strip_cmd=( $(tc-getPROG LLVM_BITCODE_STRIP llvm-bitcode-strip) )
			command -v "${llvm_strip_cmd[0]}" >/dev/null || die "strip-lto-bytecode: unable to find ${llvm_strip_cmd[0]}"
			for file in "${files[@]}" ; do
				"${llvm_strip_cmd[@]}" \
					-r "${file}" \
					-o "${file}" || die "Stripping bytecode in ${file} failed"
			done
			;;
	esac
}

fi

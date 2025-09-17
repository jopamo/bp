# @ECLASS: flag-o-matic.eclass
# @SUPPORTED_EAPIS: 6 7 8

case ${EAPI} in
	6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_FLAG_O_MATIC_ECLASS} ]]; then
	_FLAG_O_MATIC_ECLASS=1

inherit toolchain-funcs

all-flag-vars() { echo {ADA,C,CPP,CXX,CCAS,F,FC,LD}FLAGS; }

# Allowed flags for strip-flags (EAPI>=7)
setup-allowed-flags() {
	ALLOWED_FLAGS=(
		-pipe -O '-O[123szg]' '-mcpu=*' '-march=*' '-mtune=*' '-mfpmath=*'
		-flto '-flto=*' -fno-lto
		'-fstack-protector*' -fstack-clash-protection '-fcf-protection=*'
		-fbounds-check -fbounds-checking
		-fno-PIE -fno-pie -nopie -no-pie
		-fharden-* -fhardcfr-*
		'-mindirect-branch=*' -mindirect-branch-register '-mfunction-return=*'
		'-mretpoline' '-mharden-sls=*' '-mbranch-protection=*'
		-fno-unit-at-a-time -fno-strict-overflow
		'-fsanitize*' '-fno-sanitize*'
		-g '-g[0-9]' -ggdb '-ggdb[0-9]' -gdwarf '-gdwarf-*' -gstabs -gstabs+ -gz -glldb
		'-fdebug-default-version=*'
		-fno-diagnostics-color '-fmessage-length=*' -fno-ident -fpermissive
		-frecord-gcc-switches -frecord-command-line '-fdiagnostics*' '-fplugin*'
		'-W*' -w '-[DUILR]*' '-Wl,*' '-fuse-ld=*'
	)

	ALLOWED_FLAGS+=(
		'-fno-stack-protector*' '-fabi-version=*'
		-fno-strict-aliasing -fno-bounds-check -fno-bounds-checking -fstrict-overflow
		-fno-omit-frame-pointer '-fno-builtin*'
		-mno-omit-leaf-frame-pointer '-mregparm=*' -mno-*
		-mips1 -mips2 -mips3 -mips4 -mips32 -mips64 -mips16 -mplt
		-msoft-float -mhard-float '-mfpu=*' -mieee -mieee-with-inexact
		'-mschedule=*' -mfloat-gprs -mspe -mno-spe
		-mtls-direct-seg-refs -mno-tls-direct-seg-refs -mflat -mno-flat
		-m32 -m64 -mx32 '-mabi=*' -mlittle-endian -mbig-endian -EL -EB
		-fPIC -mlive-g0 '-mcmodel=*' -mstack-bias -mno-stack-bias
		'-m*-toc' '-mfloat-abi=*' '-mtls-dialect=*'
		-mfix-r4000 -mfix-r4400 -mfix-r10000
		'-mr10k-cache-barrier=*' -mthumb -marm -ffixed-x18
		-mno-fma4 -mno-movbe -mno-xop -mno-lwp
		-mno-fsgsbase -mno-rdrnd -mno-f16c -mno-bmi -mno-tbm
		-mno-avx2 -mno-bmi2 -mno-fma -mno-lzcnt
		-mno-fxsr -mno-hle -mno-rtm -mno-xsave -mno-xsaveopt
		-mno-avx512cd -mno-avx512er -mno-avx512f -mno-avx512pf -mno-sha
	)
	ALLOWED_FLAGS+=( -mstackrealign '-mpreferred-stack-boundary=*' '-mincoming-stack-boundary=*' )
	ALLOWED_FLAGS+=( '--unwindlib=*' '--rtlib=*' '--stdlib=*' )
}

_filter-hardened() {
	local f
	for f in "$@" ; do
		case "${f}" in
			-fPIC|-fpic|-fPIE|-fpie|-Wl,pie|-pie)
				if gcc-specs-pie || tc-enables-pie; then
					if ! is-flagq -nopie && ! is-flagq -no-pie; then
						if test-flags -nopie &>/dev/null; then
							append-flags -nopie
						else
							append-flags -no-pie
						fi
					fi
				fi
				;;
			-fstack-protector|-fstack-protector-strong)
				if gcc-specs-ssp || tc-enables-ssp || tc-enables-ssp-strong; then
					is-flagq -fno-stack-protector || append-flags $(test-flags -fno-stack-protector)
				fi
				;;
			-fstack-protector-all)
				if gcc-specs-ssp-to-all || tc-enables-ssp-all; then
					is-flagq -fno-stack-protector-all || append-flags $(test-flags -fno-stack-protector-all)
				fi
				;;
			-fno-strict-overflow)
				if gcc-specs-nostrict; then
					is-flagq -fstrict-overflow || append-flags $(test-flags -fstrict-overflow)
				fi
				;;
			-D_GLIBCXX_ASSERTIONS|-D_LIBCPP_ENABLE_ASSERTIONS|-D_LIBCPP_ENABLE_HARDENED_MODE)
				tc-enables-cxx-assertions && append-cppflags -U_GLIBCXX_ASSERTIONS -U_LIBCPP_ENABLE_ASSERTIONS -U_LIBCPP_ENABLE_HARDENED_MODE
				;;
			-D_FORTIFY_SOURCE=*)
				tc-enables-fortify-source && append-cppflags -U_FORTIFY_SOURCE
				;;
		esac
	done
}

_filter-var() {
	local var=$1 new=() f x
	shift
	for f in ${!var}; do
		for x in "$@"; do [[ $f == $x ]] && continue 2; done
		new+=( "$f" )
	done
	export ${var}="${new[*]}"
}

filter-flags() {
	_filter-hardened "$@"
	local v
	for v in $(all-flag-vars); do
		_filter-var ${v} "$@"
	done
}

filter-lfs-flags() { filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_TIME_BITS=64; }
filter-lto() { filter-flags '-flto*' -fwhole-program-vtables '-fsanitize=cfi*'; }
filter-defs() { filter-flags '-Wl,-z,defs'; }
filter-ldflags() { _filter-var LDFLAGS "$@"; }
filter-clang() {
	replace-flags -O3 -O2;
	replace-flags '-flto*' -flto;
	filter-flags -fgraphite-identity -floop-nest-optimize -ftree-loop-distribution -fdevirtualize-at-ltrans -fipa-pta;
	filter-flags -fuse-linker-plugin '-D_FORTIFY_SOURCE*' -D_GLIBCXX_ASSERTIONS '-Wl,-z,combreloc' '-Wl,-z,defs' '-Wl,-z,now';
	filter-flags '-Wl,-z,relro' -fstack-clash-protection -fstack-protector-strong '-mbranch-protection*';
	strip-flags
}

filter-gcc() {
	replace-flags -O3 -O2
	filter-flags -fgraphite-identity -floop-nest-optimize -ftree-loop-distribution -fdevirtualize-at-ltrans -fipa-pta;
	filter-flags -fuse-linker-plugin '-D_FORTIFY_SOURCE*' -D_GLIBCXX_ASSERTIONS '-Wl,-z,combreloc' '-Wl,-z,defs' '-Wl,-z,now';
	filter-flags '-Wl,-z,relro' -fstack-clash-protection -fstack-protector-strong;
}

append-cppflags() { [[ $# -eq 0 ]] || export CPPFLAGS+=" $*"; }
append-cflags() { [[ $# -eq 0 ]] || export CFLAGS+=" $*"; }
append-cxxflags() { [[ $# -eq 0 ]] || export CXXFLAGS+=" $*"; }
append-fflags() { [[ $# -eq 0 ]] || { export FFLAGS+=" $*"; export FCFLAGS+=" $*"; }; }
append-lfs-flags() { append-cppflags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_TIME_BITS=64; }

append-ldflags() {
	[[ $# -eq 0 ]] && return
	local f
	for f in "$@"; do
		[[ $f == -l* ]] && eqawarn "Appending library link instruction ($f) in LDFLAGS is discouraged"
	done
	export LDFLAGS+=" $*"
}

append-flags() {
	[[ $# -eq 0 ]] && return
	case " $* " in
		*' '-[DIU]*) eqawarn "Use append-cppflags for preprocessor flags" ;;
		*' '-L*|*' '-Wl,*) eqawarn "Use append-ldflags for linker flags" ;;
	esac
	append-cflags "$@"
	append-cxxflags "$@"
	append-fflags "$@"
}

replace-flags() {
	[[ $# == 2 ]] || die "Usage: replace-flags <old> <new>"
	local var new=() f
	for var in $(all-flag-vars); do
		new=()
		for f in ${!var}; do
			[[ $f == $1 ]] && f=$2
			new+=( "$f" )
		done
		export ${var}="${new[*]}"
	done
}

replace-cpu-flags() {
	local newcpu=${@: -1}
	while [[ $# -gt 1 ]]; do
		replace-flags "-march=$1" "-march=${newcpu}"
		replace-flags "-mcpu=$1" "-mcpu=${newcpu}"
		replace-flags "-mtune=$1" "-mtune=${newcpu}"
		shift
	done
}

_is_flagq() {
	local var="$1[*]" x
	for x in ${!var}; do [[ $x == "$2" ]] && return 0; done
	return 1
}

is-flagq() {
	for v in $(all-flag-vars); do
		_is_flagq ${v} "$1" && return 0
	done
	return 1
}
is-flag() { is-flagq "$@" && echo true; }

is-ldflagq() { _is_flagq LDFLAGS "$1"; }
is-ldflag() { is-ldflagq "$@" && echo true; }

filter-mfpmath() {
	local orig_mfpmath=$(get-flag -mfpmath)
	local new_math=$(get-flag mfpmath)
	new_math=${new_math/both/387,sse}; new_math=" ${new_math//[,+]/ } "
	local x
	for x in "$@"; do new_math=${new_math/ $x / }; done
	new_math=${new_math// /,}
	if [[ -z $new_math ]]; then
		filter-flags ${orig_mfpmath}
	else
		replace-flags ${orig_mfpmath} "-mfpmath=${new_math}"
	fi
}

strip-flags() {
	[[ $# -ne 0 ]] && die "strip-flags takes no arguments"
	setup-allowed-flags
	set -f
	local var
	for var in $(all-flag-vars); do
		local new=() x y
		for x in ${!var}; do
			for y in "${ALLOWED_FLAGS[@]}"; do
				[[ $x == $y ]] && { new+=( "$x" ); break; }
			done
		done
		if _is_flagq ${var} "-O*" && ! _is_flagq new "-O*"; then
			new+=( -O2 )
		fi
		[[ "${!var}" != "${new[*]}" ]] && einfo "strip-flags: ${var}: changed '${!var}' -> '${new[*]}'"
		export ${var}="${new[*]}"
	done
	set +f
}

_filter-hardened() { :; }  # override if needed in EAPI>=7 ?

test-flag-PROG() {
	[[ ${EAPI} == [67] ]] || die "Internal function not available in EAPI ${EAPI}."
	_test-flag-PROG "$@"
}
_test-flag-PROG() {
	local comp=$(tc-get$1); shift
	local lang=$1; shift
	[[ -z "$comp" || -z "$1" ]] && return 1

	# Just create a small source for the chosen language.
	local in_src in_ext extra=()
	case "$lang" in
		c) in_ext=c; in_src='int main(){return 0;}'; extra=(-xc -c) ;;
		c++) in_ext=cc; in_src='int main(){return 0;}' ; extra=(-xc++ -c) ;;
		f77) in_ext=f; in_src='      end'; extra=(-xf77 -c) ;;
		f95) in_ext=f90; in_src='end'; extra=(-xf95 -c) ;;
		c+ld)
			in_ext=c; in_src='int main(){return 0;}'
			is-ldflagq -fuse-ld=* && extra+=($(get-flag -fuse-ld=*))
			extra+=(-xc)
			;;
	esac
	local test_in="${T}/test-flag.${in_ext}"
	local test_out="${T}/test-flag.exe"

	echo "$in_src" > "$test_in" || die "Failed to create '$test_in'"
	"$comp" -Werror "$@" "${extra[@]}" "$test_in" -o "$test_out" &>/dev/null
}

test-flag-CC() { _test-flag-PROG CC c "$@"; }
test-flag-CXX() { _test-flag-PROG CXX c++ "$@"; }
test-flag-F77() { _test-flag-PROG F77 f77 "$@"; }
test-flag-FC()  { _test-flag-PROG FC f95 "$@"; }
test-flag-CCLD(){ _test-flag-PROG CC c+ld "$@"; }

test-flags-PROG() {
	[[ ${EAPI} == [67] ]] || die "Internal function not available in EAPI ${EAPI}."
	_test-flags-PROG "$@"
}
_test-flags-PROG() {
	local comp=$1; shift
	[[ -z $comp ]] && return 1
	local good=()
	while [[ $# -gt 0 ]]; do
		case $1 in
			--param|-B)
				test-flag-${comp} "$1" "$2" && good+=("$1" "$2")
				shift 2
				;;
			*)
				test-flag-${comp} "$1" && good+=("$1")
				shift
				;;
		esac
	done
	echo "${good[*]}"
	[[ ${#good[@]} -gt 0 ]]
}

test-flags-CC()   { _test-flags-PROG CC "$@"; }
test-flags-CXX()  { _test-flags-PROG CXX "$@"; }
test-flags-F77()  { _test-flags-PROG F77 "$@"; }
test-flags-FC()   { _test-flags-PROG FC "$@"; }
test-flags-CCLD() { _test-flags-PROG CCLD "$@"; }
test-flags()      { test-flags-CC "$@"; }

test_version_info() {
	[[ $($(tc-getCC) --version 2>&1) == *$1* ]]
}

strip-unsupported-flags() {
	[[ $# -ne 0 ]] && die "strip-unsupported-flags takes no arguments"
	CFLAGS=$(test-flags-CC ${CFLAGS})
	CXXFLAGS=$(test-flags-CXX ${CXXFLAGS})
	FFLAGS=$(test-flags-F77 ${FFLAGS})
	FCFLAGS=$(test-flags-FC ${FCFLAGS})
	LDFLAGS=$(test-flags-CCLD ${LDFLAGS})
}

get-flag() {
	[[ $# -eq 1 ]] || die "Usage: get-flag <flag>"
	local f var want="$1"
	for var in $(all-flag-vars); do
		for f in ${!var}; do
			[[ $f == *${want}* ]] && echo "${f/-${want}=}" && return 0
		done
	done
	return 1
}

append-libs() {
	[[ $# -eq 0 ]] && return
	local flag
	for flag in "$@"; do
		[[ -z "${flag// }" ]] && eqawarn "Appending empty argument to LIBS" && continue
		case $flag in
			-[lL]*) LIBS+=" ${flag}" ;;
			-*) eqawarn "Appending non-library to LIBS: $flag" ; LIBS+=" ${flag}" ;;
			*) LIBS+=" -l${flag}" ;;
		esac
	done
}

raw-ldflags() {
	local input="$*"
	[[ -z $input ]] && input=${LDFLAGS}
	local x out=()
	for x in ${input}; do
		case $x in
			-Wl,*) x=${x#-Wl,}; out+=( ${x//,/ } ) ;;
			*) : ;; # skip driver flags
		esac
	done
	echo "${out[@]}"
}

no-as-needed() {
	[[ $(tc-getLD -v 2>&1) == *GNU* ]] && echo "-Wl,--no-as-needed"
}

test-compile() {
	local lang=$1 code=$2
	shift 2
	[[ -z $lang || -z $code ]] && return 1

	local compiler f_in f_out args=() libs=()
	case $lang in
		c)
			compiler=$(tc-getCC)
			f_in="${T}/test.c"
			f_out="${T}/test.o"
			args+=(${CFLAGS} -xc -c)
			;;
		c++)
			compiler=$(tc-getCXX)
			f_in="${T}/test.cc"
			f_out="${T}/test.o"
			args+=(${CXXFLAGS} -xc++ -c)
			;;
		f77)
			compiler=$(tc-getF77)
			f_in="${T}/test.f"
			f_out="${T}/test.o"
			args+=(${FFLAGS} -xf77 -c)
			;;
		f95)
			compiler=$(tc-getFC)
			f_in="${T}/test.f90"
			f_out="${T}/test.o"
			args+=(${FCFLAGS} -xf95 -c)
			;;
		c+ld)
			compiler=$(tc-getCC)
			f_in="${T}/test.c"
			f_out="${T}/test.exe"
			args+=(${CFLAGS} ${LDFLAGS} -xc)
			libs+=(${LIBS})
			;;
		c+++ld)
			compiler=$(tc-getCXX)
			f_in="${T}/test.cc"
			f_out="${T}/test.exe"
			args+=(${CXXFLAGS} ${LDFLAGS} -xc++)
			libs+=(${LIBS})
			;;
		f77+ld)
			compiler=$(tc-getF77)
			f_in="${T}/test.f"
			f_out="${T}/test.exe"
			args+=(${FFLAGS} ${LDFLAGS} -xf77)
			libs+=(${LIBS})
			;;
		f95+ld)
			compiler=$(tc-getFC)
			f_in="${T}/test.f90"
			f_out="${T}/test.exe"
			args+=(${FCFLAGS} ${LDFLAGS} -xf95)
			libs+=(${LIBS})
			;;
		*) die "Unknown test language: $lang"
	esac
	echo "$code" > "$f_in" || die "Creating $f_in failed"
	"$compiler" "${args[@]}" "$f_in" -o "$f_out" "${libs[@]}" &>/dev/null
}

append-atomic-flags() {
	test-flags-CCLD -latomic &>/dev/null || return
	append-libs "-Wl,--push-state,--as-needed,-latomic,--pop-state"
}

fi

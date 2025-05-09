# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: meson.eclass
# @MAINTAINER:
# base-system@gentoo.org
# @SUPPORTED_EAPIS: 7 8
# @BLURB: common ebuild functions for meson-based packages
# @DESCRIPTION:
# This eclass contains the default phase functions for packages which
# use the meson build system.
#
# @EXAMPLE:
# Typical ebuild using meson.eclass:
#
# @CODE
# EAPI=8
#
# inherit meson
#
# ...
#
# src_configure() {
# 	local emesonargs=(
# 		$(meson_use qt5)
# 		$(meson_feature threads)
# 		$(meson_use bindist official_branding)
# 	)
# 	meson_src_configure
# }
#
# ...
#
# @CODE

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_MESON_ECLASS} ]]; then
_MESON_ECLASS=1

inherit flag-o-matic multiprocessing ninja-utils python-utils-r1 toolchain-funcs

BDEPEND=">=app-dev/meson-1.2.3
	${NINJA_DEPEND}
"

# @ECLASS_VARIABLE: BUILD_DIR
# @DEFAULT_UNSET
# @DESCRIPTION:
# Build directory, location where all generated files should be placed.
# If this isn't set, it defaults to ${WORKDIR}/${P}-build.

# @ECLASS_VARIABLE: MESON_VERBOSE
# @USER_VARIABLE
# @DESCRIPTION:
# Set to OFF to disable verbose messages during compilation
: "${MESON_VERBOSE:=ON}"

# @ECLASS_VARIABLE: EMESON_BUILDTYPE
# @DESCRIPTION:
# The buildtype value to pass to meson setup.
: "${EMESON_BUILDTYPE=release}"

# @ECLASS_VARIABLE: EMESON_SOURCE
# @DEFAULT_UNSET
# @DESCRIPTION:
# The location of the source files for the project; this is the source
# directory to pass to meson.
# If this isn't set, it defaults to ${S}

# @VARIABLE: emesonargs
# @DEFAULT_UNSET
# @DESCRIPTION:
# Optional meson arguments as Bash array; this should be defined before
# calling meson_src_configure.

# @VARIABLE: MYMESONARGS
# @DEFAULT_UNSET
# @DESCRIPTION:
# User-controlled environment variable containing arguments to be passed to
# meson in meson_src_configure.

# @FUNCTION: _meson_env_array
# @INTERNAL
# @DESCRIPTION:
# Parses the command line flags and converts them into an array suitable for
# use in a cross file.
#
# Input: --single-quote=\' --double-quote=\" --dollar=\$ --backtick=\`
#        --backslash=\\ --full-word-double="Hello World"
#        --full-word-single='Hello World'
#        --full-word-backslash=Hello\ World
#        --simple --unicode-8=© --unicode-16=𐐷 --unicode-32=𐤅
#
# Output: ['--single-quote=\'', '--double-quote="', '--dollar=$',
#          '--backtick=`', '--backslash=\\', '--full-word-double=Hello World',
#          '--full-word-single=Hello World',
#          '--full-word-backslash=Hello World', '--simple', '--unicode-8=©',
#          '--unicode-16=𐐷', '--unicode-32=𐤅']
#
_meson_env_array() {
	meson-format-array "$@"
}

# @FUNCTION: _meson_get_machine_info
# @USAGE: <tuple>
# @RETURN: system/cpu_family/cpu variables
# @INTERNAL
# @DESCRIPTION:
# Translate toolchain tuple into machine values for meson.
_meson_get_machine_info() {
	local tuple=$1

	# system roughly corresponds to uname -s (lowercase)
	case ${tuple} in
		*-darwin*)       system=darwin ;;
		*-linux*)        system=linux ;;
		mingw*|*-mingw*) system=windows ;;
		*-solaris*)      system=sunos ;;
	esac

	cpu_family=$(tc-arch "${tuple}")
	case ${cpu_family} in
		amd64) cpu_family=x86_64 ;;
		arm64) cpu_family=aarch64 ;;
		riscv)
			case ${tuple} in
				riscv32*) cpu_family=riscv32 ;;
				riscv64*) cpu_family=riscv64 ;;
			esac ;;
	esac

	# This may require adjustment based on CFLAGS
	cpu=${tuple%%-*}
}

# @FUNCTION: _meson_create_cross_file
# @RETURN: path to cross file
# @INTERNAL
# @DESCRIPTION:
# Creates a cross file. meson uses this to define settings for
# cross-compilers. This function is called from meson_src_configure.
_meson_create_cross_file() {
	local system cpu_family cpu
	_meson_get_machine_info "${CHOST}"

	local fn=${T}/meson.${CHOST}.${ABI}.ini

	cat > "${fn}" <<-EOF
	[binaries]
	ar = $(_meson_env_array "$(tc-getAR)")
	c = $(_meson_env_array "$(tc-getCC)")
	cpp = $(_meson_env_array "$(tc-getCXX)")
	fortran = $(_meson_env_array "$(tc-getFC)")
	llvm-config = '$(tc-getPROG LLVM_CONFIG llvm-config)'
	nm = $(_meson_env_array "$(tc-getNM)")
	objc = $(_meson_env_array "$(tc-getPROG OBJC cc)")
	objcopy = $(_meson_env_array "$(tc-getOBJCOPY)")
	objcpp = $(_meson_env_array "$(tc-getPROG OBJCXX c++)")
	# TODO: Cleanup 'pkgconfig' and keep just 'pkg-config' once we require
	# >=1.3.0.
	pkgconfig = '$(tc-getPKG_CONFIG)'
	pkg-config = '$(tc-getPKG_CONFIG)'
	strip = $(_meson_env_array "$(tc-getSTRIP)")
	windres = $(_meson_env_array "$(tc-getRC)")

	[built-in options]
	c_args = $(_meson_env_array "${CFLAGS} ${CPPFLAGS}")
	c_link_args = $(_meson_env_array "${CFLAGS} ${LDFLAGS}")
	cpp_args = $(_meson_env_array "${CXXFLAGS} ${CPPFLAGS}")
	cpp_link_args = $(_meson_env_array "${CXXFLAGS} ${LDFLAGS}")
	fortran_args = $(_meson_env_array "${FCFLAGS}")
	fortran_link_args = $(_meson_env_array "${FCFLAGS} ${LDFLAGS}")
	objc_args = $(_meson_env_array "${OBJCFLAGS} ${CPPFLAGS}")
	objc_link_args = $(_meson_env_array "${OBJCFLAGS} ${LDFLAGS}")
	objcpp_args = $(_meson_env_array "${OBJCXXFLAGS} ${CPPFLAGS}")
	objcpp_link_args = $(_meson_env_array "${OBJCXXFLAGS} ${LDFLAGS}")

	[properties]
	needs_exe_wrapper = true
	sys_root = '${SYSROOT}'
	pkg_config_libdir = '${PKG_CONFIG_LIBDIR:-${EPREFIX}/usr/lib/pkgconfig}'

	[host_machine]
	system = '${system}'
	cpu_family = '${cpu_family}'
	cpu = '${cpu}'
	endian = '$(tc-endian "${CHOST}")'
	EOF

	echo "${fn}"
}

# @FUNCTION: _meson_create_native_file
# @RETURN: path to native file
# @INTERNAL
# @DESCRIPTION:
# Creates a native file. meson uses this to define settings for
# native compilers. This function is called from meson_src_configure.
_meson_create_native_file() {
	local system cpu_family cpu
	_meson_get_machine_info "${CBUILD}"

	local fn=${T}/meson.${CBUILD}.${ABI}.ini

	cat > "${fn}" <<-EOF
	[binaries]
	ar = $(_meson_env_array "$(tc-getBUILD_AR)")
	c = $(_meson_env_array "$(tc-getBUILD_CC)")
	cpp = $(_meson_env_array "$(tc-getBUILD_CXX)")
	fortran = $(_meson_env_array "$(tc-getBUILD_PROG FC gfortran)")
	llvm-config = '$(tc-getBUILD_PROG LLVM_CONFIG llvm-config)'
	nm = $(_meson_env_array "$(tc-getBUILD_NM)")
	objc = $(_meson_env_array "$(tc-getBUILD_PROG OBJC cc)")
	objcopy = $(_meson_env_array "$(tc-getBUILD_OBJCOPY)")
	objcpp = $(_meson_env_array "$(tc-getBUILD_PROG OBJCXX c++)")
	# TODO: Cleanup 'pkgconfig' and keep just 'pkg-config' once we require
	# >=1.3.0.
	pkgconfig = '$(tc-getBUILD_PKG_CONFIG)'
	pkg-config = '$(tc-getBUILD_PKG_CONFIG)'
	strip = $(_meson_env_array "$(tc-getBUILD_STRIP)")
	windres = $(_meson_env_array "$(tc-getBUILD_PROG RC windres)")

	[built-in options]
	c_args = $(_meson_env_array "${BUILD_CFLAGS} ${BUILD_CPPFLAGS}")
	c_link_args = $(_meson_env_array "${BUILD_CFLAGS} ${BUILD_LDFLAGS}")
	cpp_args = $(_meson_env_array "${BUILD_CXXFLAGS} ${BUILD_CPPFLAGS}")
	cpp_link_args = $(_meson_env_array "${BUILD_CXXFLAGS} ${BUILD_LDFLAGS}")
	fortran_args = $(_meson_env_array "${BUILD_FCFLAGS}")
	fortran_link_args = $(_meson_env_array "${BUILD_FCFLAGS} ${BUILD_LDFLAGS}")
	objc_args = $(_meson_env_array "${BUILD_OBJCFLAGS} ${BUILD_CPPFLAGS}")
	objc_link_args = $(_meson_env_array "${BUILD_OBJCFLAGS} ${BUILD_LDFLAGS}")
	objcpp_args = $(_meson_env_array "${BUILD_OBJCXXFLAGS} ${BUILD_CPPFLAGS}")
	objcpp_link_args = $(_meson_env_array "${BUILD_OBJCXXFLAGS} ${BUILD_LDFLAGS}")

	[properties]
	needs_exe_wrapper = false
	pkg_config_libdir = '${BUILD_PKG_CONFIG_LIBDIR:-${EPREFIX}/usr/lib/pkgconfig}'

	[build_machine]
	system = '${system}'
	cpu_family = '${cpu_family}'
	cpu = '${cpu}'
	endian = '$(tc-endian "${CBUILD}")'
	EOF

	echo "${fn}"
}

# @FUNCTION: meson_use
# @USAGE: <USE flag> [option name]
# @DESCRIPTION:
# Given a USE flag and meson project option, outputs a string like:
#
#   -Doption=true
#   -Doption=false
#
# If the project option is unspecified, it defaults to the USE flag.
meson_use() {
	usex "$1" "-D${2-$1}=true" "-D${2-$1}=false"
}

# @FUNCTION: meson_feature
# @USAGE: <USE flag> [option name]
# @DESCRIPTION:
# Given a USE flag and meson project option, outputs a string like:
#
#   -Doption=enabled
#   -Doption=disabled
#
# If the project option is unspecified, it defaults to the USE flag.
meson_feature() {
	usex "$1" "-D${2-$1}=enabled" "-D${2-$1}=disabled"
}

# @FUNCTION: setup_meson_src_configure
# @DESCRIPTION:
# Calculate the command line which meson should use, and other relevant
# variables. Invoke via "${MESONARGS[@]}" in the calling environment.
# This function is called from meson_src_configure.
setup_meson_src_configure() {
	MESONARGS=()
	if tc-is-lto; then
		# We want to connect -flto in *FLAGS to the dedicated meson option,
		# to ensure that meson has visibility into what the user set. Although
		# it is unlikely projects will check `get_option('b_lto')` and change
		# their behavior, individual targets which are broken with LTO can
		# disable it per target. Injecting via *FLAGS means that meson cannot
		# strip -flto from that target.
		MESONARGS+=( -Db_lto=true )

		# respect -flto value, e.g. -flto=8, -flto=thin
		local v=$(get-flag flto)
		case ${v} in
			thin)
				MESONARGS+=( -Db_lto_mode=thin )
				;;
			''|*[!0-9]*)
				;;
			*)
				MESONARGS+=( -Db_lto_threads=${v} )
				;;
		esac
		# finally, remove it from *FLAGS to avoid passing it:
		# - twice, with potentially different values
		# - on excluded targets
		filter-lto
	else
		# Prevent projects from enabling LTO by default.  In Gentoo, LTO is
		# enabled via setting *FLAGS appropriately.
		MESONARGS+=( -Db_lto=false )
	fi

	local BUILD_CFLAGS=${BUILD_CFLAGS}
	local BUILD_CPPFLAGS=${BUILD_CPPFLAGS}
	local BUILD_CXXFLAGS=${BUILD_CXXFLAGS}
	local BUILD_FCFLAGS=${BUILD_FCFLAGS}
	local BUILD_OBJCFLAGS=${BUILD_OBJCFLAGS}
	local BUILD_OBJCXXFLAGS=${BUILD_OBJCXXFLAGS}
	local BUILD_LDFLAGS=${BUILD_LDFLAGS}
	local BUILD_PKG_CONFIG_LIBDIR=${BUILD_PKG_CONFIG_LIBDIR}
	local BUILD_PKG_CONFIG_PATH=${BUILD_PKG_CONFIG_PATH}

	if tc-is-cross-compiler; then
		: "${BUILD_CFLAGS:=-O1 -pipe}"
		: "${BUILD_CXXFLAGS:=-O1 -pipe}"
		: "${BUILD_FCFLAGS:=-O1 -pipe}"
		: "${BUILD_OBJCFLAGS:=-O1 -pipe}"
		: "${BUILD_OBJCXXFLAGS:=-O1 -pipe}"
	else
		: "${BUILD_CFLAGS:=${CFLAGS}}"
		: "${BUILD_CPPFLAGS:=${CPPFLAGS}}"
		: "${BUILD_CXXFLAGS:=${CXXFLAGS}}"
		: "${BUILD_FCFLAGS:=${FCFLAGS}}"
		: "${BUILD_LDFLAGS:=${LDFLAGS}}"
		: "${BUILD_OBJCFLAGS:=${OBJCFLAGS}}"
		: "${BUILD_OBJCXXFLAGS:=${OBJCXXFLAGS}}"
		: "${BUILD_PKG_CONFIG_LIBDIR:=${PKG_CONFIG_LIBDIR}}"
		: "${BUILD_PKG_CONFIG_PATH:=${PKG_CONFIG_PATH}}"
	fi

	MESONARGS+=(
		--libdir "lib"
		--localstatedir "${EPREFIX}/var"
		--prefix "${EPREFIX}/usr"
		--sysconfdir "${EPREFIX}/etc"
		-Dsbindir="${EPREFIX}/usr/bin"
		--wrap-mode nodownload
		--build.pkg-config-path "${BUILD_PKG_CONFIG_PATH}${BUILD_PKG_CONFIG_PATH:+:}${EPREFIX}/usr/share/pkgconfig"
		--pkg-config-path "${PKG_CONFIG_PATH}${PKG_CONFIG_PATH:+:}${EPREFIX}/usr/share/pkgconfig"
		--native-file "$(_meson_create_native_file)"

		# gcc[pch] is masked in profiles due to consistent bugginess
		# without forcing this off, some packages may fail too (like gjs,
		# bug #839549), but in any case, we don't want to bother attempting
		# this.
		-Db_pch=false

		# It's Gentoo policy to not have builds die on blanket -Werror, as it's
		# an upstream development matter. bug #754279.
		-Dwerror=false

		"${ltoflags[@]}"
	)

	if [[ -n ${EMESON_BUILDTYPE} ]]; then
		MESONARGS+=( -Dbuildtype="${EMESON_BUILDTYPE}" )
	fi

	if tc-is-cross-compiler; then
		MESONARGS+=( --cross-file "$(_meson_create_cross_file)" )
	fi

	# Handle quoted whitespace
	eval "local -a MYMESONARGS=( ${MYMESONARGS} )"

	MESONARGS+=(
		# Arguments from ebuild
		"${emesonargs[@]}"

		# Arguments passed to this function
		"$@"

		# Arguments from user
		"${MYMESONARGS[@]}"
	)

	# Used by symbolextractor.py
	# https://bugs.gentoo.org/717720
	tc-export NM
	tc-getPROG READELF readelf >/dev/null

	# https://bugs.gentoo.org/721786
	export BOOST_INCLUDEDIR="${BOOST_INCLUDEDIR-${EPREFIX}/usr/include}"
	export BOOST_LIBRARYDIR="${BOOST_LIBRARYDIR-${EPREFIX}/usr/lib}"
}

# @FUNCTION: meson_src_configure
# @USAGE: [extra meson arguments]
# @DESCRIPTION:
# This is the meson_src_configure function.
meson_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	[[ -n "${NINJA_DEPEND}" ]] || ewarn "Unknown value '${NINJA}' for \${NINJA}"

	BUILD_DIR="${BUILD_DIR:-${WORKDIR}/${P}-build}"

	# https://bugs.gentoo.org/625396
	python_export_utf8_locale

	(
		setup_meson_src_configure "$@"
		MESONARGS+=(
			# Source directory
			"${EMESON_SOURCE:-${S}}"

			# Build directory
			"${BUILD_DIR}"
		)

		export -n {C,CPP,CXX,F,OBJC,OBJCXX,LD}FLAGS PKG_CONFIG_{LIBDIR,PATH}
		echo meson setup "${MESONARGS[@]}" >&2
		meson setup "${MESONARGS[@]}"
	) || die -n
}

# @FUNCTION: meson_src_compile
# @USAGE: [extra ninja arguments]
# @DESCRIPTION:
# This is the meson_src_compile function.
meson_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	pushd "${BUILD_DIR}" > /dev/null || die

	local mesoncompileargs=(
		--jobs "$(get_makeopts_jobs 0)"
		--load-average "$(get_makeopts_loadavg 0)"
	)

	case ${MESON_VERBOSE} in
		OFF) ;;
		*) mesoncompileargs+=( --verbose ) ;;
	esac

	mesoncompileargs+=( "$@" )

	set -- meson compile "${mesoncompileargs[@]}"
	echo "$@" >&2
	"$@" || die -n "compile failed"

	popd > /dev/null || die
}

# @FUNCTION: meson_src_test
# @USAGE: [extra meson test arguments]
# @DESCRIPTION:
# This is the meson_src_test function.
meson_src_test() {
	debug-print-function ${FUNCNAME} "$@"

	pushd "${BUILD_DIR}" > /dev/null || die

	local mesontestargs=(
		--print-errorlogs
		--num-processes "$(makeopts_jobs "${MAKEOPTS}")"
		"$@"
	)

	set -- meson test "${mesontestargs[@]}"
	echo "$@" >&2
	"$@" || die -n "tests failed"

	popd > /dev/null || die
}

# @FUNCTION: meson_install
# @USAGE: [extra meson install arguments]
# @DESCRIPTION:
# Calls meson install with suitable arguments
meson_install() {
	debug-print-function ${FUNCNAME} "$@"

	pushd "${BUILD_DIR}" > /dev/null || die

	local mesoninstallargs=(
		--destdir "${D}"
		--no-rebuild
		"$@"
	)

	set -- meson install "${mesoninstallargs[@]}"
	echo "$@" >&2
	"$@" || die -n "install failed"

	popd > /dev/null || die

	cleanup_install
	dedup_symlink "${D}"
}

# @FUNCTION: meson_src_install
# @USAGE: [extra meson install arguments]
# @DESCRIPTION:
# This is the meson_src_install function.
meson_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	meson_install "$@"
}

fi

EXPORT_FUNCTIONS src_configure src_compile src_test src_install

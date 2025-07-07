# Distributed under the terms of the GNU General Public License v2

# @ECLASS: qmake-utils.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Common functions for qmake-based packages.

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_QMAKE_UTILS_ECLASS} ]]; then
_QMAKE_UTILS_ECLASS=1

inherit emoji toolchain-funcs

qt5_get_bindir()      { echo /usr/bin; }
qt5_get_headerdir()   { echo /usr/include/qt5; }
qt5_get_libdir()      { echo /usr/lib; }
qt5_get_mkspecsdir()  { echo /usr/lib/qt5/mkspecs; }
qt5_get_plugindir()   { echo /usr/lib/qt5/plugins; }
qt5_get_qmake_args() {
	cat <<-EOF
		QMAKE_AR="$(tc-getAR) cqs"
		QMAKE_CC="$(tc-getCC)"
		QMAKE_LINK_C="$(tc-getCC)"
		QMAKE_LINK_C_SHLIB="$(tc-getCC)"
		QMAKE_CXX="$(tc-getCXX)"
		QMAKE_LINK="$(tc-getCXX)"
		QMAKE_LINK_SHLIB="$(tc-getCXX)"
		QMAKE_OBJCOPY="$(tc-getOBJCOPY)"
		QMAKE_RANLIB=
		QMAKE_STRIP=
		QMAKE_CFLAGS="${CFLAGS}"
		QMAKE_CFLAGS_RELEASE=
		QMAKE_CFLAGS_DEBUG=
		QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO=
		QMAKE_CXXFLAGS="${CXXFLAGS}"
		QMAKE_CXXFLAGS_RELEASE=
		QMAKE_CXXFLAGS_DEBUG=
		QMAKE_CXXFLAGS_RELEASE_WITH_DEBUGINFO=
		QMAKE_LFLAGS="${LDFLAGS}"
		QMAKE_LFLAGS_RELEASE=
		QMAKE_LFLAGS_DEBUG=
		QMAKE_LFLAGS_RELEASE_WITH_DEBUGINFO=
	EOF
}
eqmake5() {
	debug-print-function ${FUNCNAME} "$@"
	log_info "Running qmake (Qt5)"
	local -a args
	mapfile -t args <<<"$(qt5_get_qmake_args)"
	"$(qt5_get_bindir)"/qmake -makefile "${args[@]}" "$@"
	local ret=$?
	if [[ $ret -ne 0 ]]; then
		log_err "Running qmake failed! (see above for details)"
		log_err "This shouldn't happen - please report to https://bugs.gentoo.org/"
		die "eqmake5 failed"
	fi
}

qt6_get_bindir()      { echo /usr/lib/qt6/bin; }
qt6_get_headerdir()   { echo /usr/include/qt6; }
qt6_get_libdir()      { echo /usr/lib; }
qt6_get_mkspecsdir()  { echo /usr/lib/qt6/mkspecs; }
qt6_get_plugindir()   { echo /usr/lib/qt6/plugins; }
qt6_get_qmake_args() {
	cat <<-EOF
		QMAKE_AR="$(tc-getAR) cqs"
		QMAKE_CC="$(tc-getCC)"
		QMAKE_LINK_C="$(tc-getCC)"
		QMAKE_LINK_C_SHLIB="$(tc-getCC)"
		QMAKE_CXX="$(tc-getCXX)"
		QMAKE_LINK="$(tc-getCXX)"
		QMAKE_LINK_SHLIB="$(tc-getCXX)"
		QMAKE_OBJCOPY="$(tc-getOBJCOPY)"
		QMAKE_RANLIB=
		QMAKE_STRIP=
		QMAKE_CFLAGS="${CFLAGS}"
		QMAKE_CFLAGS_RELEASE=
		QMAKE_CFLAGS_DEBUG=
		QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO=
		QMAKE_CXXFLAGS="${CXXFLAGS}"
		QMAKE_CXXFLAGS_RELEASE=
		QMAKE_CXXFLAGS_DEBUG=
		QMAKE_CXXFLAGS_RELEASE_WITH_DEBUGINFO=
		QMAKE_LFLAGS="${LDFLAGS}"
		QMAKE_LFLAGS_RELEASE=
		QMAKE_LFLAGS_DEBUG=
		QMAKE_LFLAGS_RELEASE_WITH_DEBUGINFO=
	EOF
}
eqmake6() {
	debug-print-function ${FUNCNAME} "$@"
	log_info "Running qmake (Qt6)"
	local -a args
	mapfile -t args <<<"$(qt6_get_qmake_args)"
	"$(qt6_get_bindir)"/qmake -makefile "${args[@]}" "$@"
	local ret=$?
	if [[ $ret -ne 0 ]]; then
		log_err "Running qmake failed! (see above for details)"
		log_err "This shouldn't happen - please report to https://bugs.gentoo.org/"
		die "eqmake6 failed"
	fi
}

fi

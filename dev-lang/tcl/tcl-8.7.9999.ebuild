# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils flag-o-matic multilib multilib-minimal toolchain-funcs versionator git-r3

MY_P="${PN}${PV}"

DESCRIPTION="tcltk/tcl - Tool Command Language - core-8-branch"
HOMEPAGE="http://www.tcl.tk/"
EGIT_REPO_URI="https://github.com/tcltk/tcl.git"
EGIT_BRANCH="core-8-branch"

LICENSE="tcltk"
SLOT="0/8.6"
KEYWORDS="amd64 arm64 x86"

IUSE="debug +threads"

SPARENT="${WORKDIR}/${P}"
S="${SPARENT}"/unix

src_prepare() {
	tc-export CC

	sed \
		-e '/chmod/s:555:755:g' \
		-i Makefile.in || die

	sed \
		-e 's:-O[2s]\?::g' \
		-i tcl.m4 || die

	eautoreconf
	default
	multilib_copy_sources
}

multilib_src_configure() {
	# We went ahead and deleted the whole compat/ subdir which means
	# the configure tests to detect broken versions need to pass (else
	# we'll fail to build).  This comes up when cross-compiling, but
	# might as well get a minor configure speed up normally.
	export ac_cv_func_memcmp_working="yes"
	export tcl_cv_str{str,toul,tod}_unbroken="ok"
	export tcl_cv_strtod_buggy="no"

	econf \
		$(use_enable debug symbols)
}

multilib_src_install() {
	#short version number
	local v1=$(get_version_component_range 1-2)
	local mylibdir=$(get_libdir)

	S= default
	# fix the tclConfig.sh to eliminate refs to the build directory
	# and drop unnecessary -L inclusion to default system libdir

	sed \
		-e "/^TCL_BUILD_LIB_SPEC=/s:-L$(pwd) *::g" \
		-e "/^TCL_LIB_SPEC=/s:-L${EPREFIX}/usr/${mylibdir} *::g" \
		-e "/^TCL_SRC_DIR=/s:${SPARENT}:${EPREFIX}/usr/${mylibdir}/tcl${v1}/include:g" \
		-e "/^TCL_BUILD_STUB_LIB_SPEC=/s:-L$(pwd) *::g" \
		-e "/^TCL_STUB_LIB_SPEC=/s:-L${EPREFIX}/usr/${mylibdir} *::g" \
		-e "/^TCL_BUILD_STUB_LIB_PATH=/s:$(pwd):${EPREFIX}/usr/${mylibdir}:g" \
		-e "/^TCL_LIB_FILE=/s:'libtcl${v1}..TCL_DBGX..so':\"libtcl${v1}\$\{TCL_DBGX\}.so\":g" \
		-i "${ED}"/usr/${mylibdir}/tclConfig.sh || die
	if use prefix && [[ ${CHOST} != *-darwin* && ${CHOST} != *-mint* ]] ; then
		sed \
			-e "/^TCL_CC_SEARCH_FLAGS=/s|'$|:${EPREFIX}/usr/${mylibdir}'|g" \
			-e "/^TCL_LD_SEARCH_FLAGS=/s|'$|:${EPREFIX}/usr/${mylibdir}'|" \
			-i "${ED}"/usr/${mylibdir}/tclConfig.sh || die
	fi

	# install private headers
	insinto /usr/${mylibdir}/tcl${v1}/include/unix
	doins *.h
	insinto /usr/${mylibdir}/tcl${v1}/include/generic
	doins "${SPARENT}"/generic/*.h
	rm -f "${ED}"/usr/${mylibdir}/tcl${v1}/include/generic/{tcl,tclDecls,tclPlatDecls}.h || die

	# install symlink for libraries
	dosym libtcl${v1}$(get_libname) /usr/${mylibdir}/libtcl$(get_libname)
	dosym libtclstub${v1}.a /usr/${mylibdir}/libtclstub.a

	if multilib_is_native_abi; then
		dosym tclsh${v1} /usr/bin/tclsh
	fi
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="core-$(ver_cut 1)-$(ver_cut 2)-branch"

inherit autotools toolchain-funcs prefix

DESCRIPTION="Tk Widget Set"
HOMEPAGE="https://www.tcl.tk/"
SNAPSHOT=9869b6b3c78ee4fb5ebda7c5743114031ccd35e7
SRC_URI="https://github.com/tcltk/tk/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="tcltk"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug truetype"

DEPEND="app-lang/tcl"
RDEPEND="
	fonts/fontconfig
	xgui-lib/libX11
"

src_prepare() {
	cd unix || die
	touch ../macosx/configure
	touch ../compat/unistd.h
	touch ../compat/stdlib.h

    sed -i 's|mkdir $(DISTDIR)/tests|mkdir -p $(DISTDIR)/tests|g' Makefile.in

	pushd "${WORKDIR}/${PN}-${SNAPSHOT}" &>/dev/null || die
	default
	popd &>/dev/null || die

	eprefixify Makefile.in

	sed \
		-e 's/FT_New_Face/XftFontOpen/g' \
		-e "s:\<pkg-config\>:$(tc-getPKG_CONFIG):" \
		-e 's:xft freetype2:xft freetype2 fontconfig:' \
		-i configure.in || die
	rm configure || die

	tc-export CC

	sed -e '/chmod/s:555:755:g' -i Makefile.in || die
	sed -e 's:-O[2s]\?::g' -i tcl.m4 || die

	cp configure.{in,ac} || die

	eautoreconf
	ln -s configure.{ac,in} || die

	cd ../macosx || die
	eautoreconf
}

src_configure() {
	cd unix || die
	econf \
		--with-tcl="${EPREFIX}/usr/lib" \
		--enable-threads \
		--disable-xss \
		--disable-corefoundation \
		$(use_enable truetype xft) \
		$(use_enable debug symbols)
}

src_install() {
	cd unix || die

	make INSTALL_ROOT="${ED}" install install-private-headers

	local v1=$(ver_cut 1-2)

	# fix the tkConfig.sh to eliminate refs to the build directory
	sed \
		-e "/^TK_BUILD_LIB_SPEC=/s:-L${S}-\w*\.\w* ::g" \
		-e "/^TK_LIB_SPEC=/s:-L${EPREFIX}/usr/lib *::g" \
		-e "/^TK_SRC_DIR=/s:${WORKDIR//\//\\/}\/${PN}-${SNAPSHOT}:${EPREFIX}/usr/lib/tk${v1}/include:g" \
		-e "/^TK_BUILD_STUB_LIB_SPEC=/s:-L${S}-\w*\.\w* *::g" \
		-e "/^TK_STUB_LIB_SPEC=/s:-L${EPREFIX}/usr/lib *::g" \
		-e "/^TK_BUILD_STUB_LIB_PATH=/s:${S}-\w*\.\w*:${EPREFIX}/usr/lib:g" \
		-e "/^TK_LIB_FILE=/s:'libtk${v1}..TK_DBGX..so':\"libtk${v1}\$\{TK_DBGX\}.so\":g" \
		-i "${ED}/usr/lib/tkConfig.sh" || die

	if use prefix && [[ ${CHOST} != *-darwin* ]]; then
		sed \
			-e "/^TK_CC_SEARCH_FLAGS=/s|'$|:${EPREFIX}/usr/lib'|g" \
			-e "/^TK_LD_SEARCH_FLAGS=/s|'$|:${EPREFIX}/usr/lib'|" \
			-i "${ED}/usr/lib/tkConfig.sh" || die
	fi

	# install private headers
	insinto /usr/lib/tk${v1}/include/unix
	doins "${S}"/unix/*.h
	insinto /usr/lib/tk${v1}/include/generic
	doins "${S}/generic/"*.h
	rm "${ED}/usr/lib/tk${v1}/include/generic/"{tk,tkDecls,tkPlatDecls}.h || die

	for x in lib${PN}${v1}.so.1 lib${PN}.so lib${PN}.so.${v1}.0 ; do
		dosym lib${PN}${v1}.so usr/lib/${x}
	done

	dosym wish${v1} /usr/bin/wish

	patchelf --set-soname lib${PN}.so.${v1}.0 "${ED}"/usr/lib/lib${PN}${v1}.so
}

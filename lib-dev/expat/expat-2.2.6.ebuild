# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils libtool multilib toolchain-funcs multilib-minimal

DESCRIPTION="Stream-oriented XML parser library"
HOMEPAGE="https://libexpat.github.io/"
SRC_URI="https://github.com/libexpat/libexpat/releases/download/R_${PV//\./_}/expat-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="examples static-libs unicode"
DEPEND="unicode? ( ${AUTOTOOLS_DEPEND} )"
RDEPEND="abi_x86_32? ( !<=app-misc/emul-linux-x86-baselibs-20130224-r6
		!app-misc/emul-linux-x86-baselibs[-abi_x86_32(-)] )"

DOCS=( README.md )

src_prepare() {
	eapply_user

	# fix interpreter to be a recent/good shell
	sed -i -e "1s:/bin/sh:${BASH}:" conftools/get-version.sh || die
	if use unicode; then
		cp -R "${S}" "${S}"w || die
		pushd "${S}"w >/dev/null
		find -name Makefile.am \
			-exec sed \
			-e 's,libexpat\.la,libexpatw.la,' \
			-e 's,libexpat_la,libexpatw_la,' \
			-i {} + || die
		eautoreconf
		popd >/dev/null
	fi
}

multilib_src_configure() {
	local myconf="$(use_enable static-libs static) --without-docbook"

	mkdir -p "${BUILD_DIR}"w || die

	if use unicode; then
		pushd "${BUILD_DIR}"w >/dev/null
		CPPFLAGS="${CPPFLAGS} -DXML_UNICODE" ECONF_SOURCE="${S}"w econf ${myconf}
		popd >/dev/null
	fi

	ECONF_SOURCE="${S}" econf ${myconf}
}

multilib_src_compile() {
	emake

	if use unicode; then
		pushd "${BUILD_DIR}"w >/dev/null
		emake -C lib
		popd >/dev/null
	fi
}

multilib_src_install() {
	emake install DESTDIR="${D}"

	if use unicode; then
		pushd "${BUILD_DIR}"w >/dev/null
		emake -C lib install DESTDIR="${D}"
		popd >/dev/null

		pushd "${ED}"/usr/$(get_libdir)/pkgconfig >/dev/null
		cp expat.pc expatw.pc
		sed -i -e '/^Libs/s:-lexpat:&w:' expatw.pc || die
		popd >/dev/null
	fi
}

multilib_src_install_all() {
	einstalldocs

	# Note: Use of HTML_DOCS would add unwanted "doc" subfolder
	docinto html
	dodoc doc/*.{css,html,png}

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi

	find "${ED}" -name "*.la" -delete || die
}

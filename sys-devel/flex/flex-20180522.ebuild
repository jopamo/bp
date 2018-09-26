# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils autotools flag-o-matic libtool multilib-minimal

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="https://github.com/westes/flex"

SNAPSHOT=98018e3f58d79e082216d406866942841d4bdf8a
SRC_URI="https://github.com/westes/flex/archive/${SNAPSHOT}.zip -> ${P}.zip"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="FLEX"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="nls static test"

# We want bison explicitly and not yacc in general #381273
RDEPEND="sys-devel/m4"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	nls? ( sys-devel/gettext )
	test? ( sys-devel/bison )"

src_prepare() {
	${S}/autogen.sh
	eautoreconf
	default

	if ! use test ; then
		sed -i \
			-e '/^SUBDIRS =/,/^$/{/tests/d}' \
			Makefile.in || die
	fi
	elibtoolize # Prefix always needs this
}

src_configure() {
	use static && append-ldflags -static

	multilib-minimal_src_configure
}

multilib_src_configure() {
	# Do not install shared libs #503522
	ECONF_SOURCE=${S} \
	econf \
		--disable-shared \
		$(use_enable nls) \
		--docdir='$(datarootdir)/doc/'${PF}
}

multilib_src_compile() {
	if multilib_is_native_abi; then
		default
	else
		cd src || die
		emake -f Makefile -f - lib <<< 'lib: $(lib_LTLIBRARIES)'
	fi
}

multilib_src_test() {
	multilib_is_native_abi && emake check
}

multilib_src_install() {
	if multilib_is_native_abi; then
		default
	else
		cd src || die
		emake DESTDIR="${D}" install-libLTLIBRARIES install-includeHEADERS
	fi
}

multilib_src_install_all() {
	einstalldocs
	dodoc ONEWS
	prune_libtool_files --all
	rm "${ED}"/usr/share/doc/${PF}/COPYING || die
	dosym flex /usr/bin/lex
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic toolchain-funcs

DESCRIPTION="Ghostscript is an interpreter for the PostScript language and for PDF"
HOMEPAGE="http://ghostscript.com/"
SRC_URI="https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs$(ver_cut 1)$(ver_cut 2)$(ver_cut 3)/ghostscript-${PV}.tar.gz"
S="${WORKDIR}/ghostscript-${PV}"

LICENSE="AGPL-3 CPL-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cups dbus gtk static-libs tiff X"

DEPEND="
	app-tex/libpaper
	fonts/fontconfig
	>=xgui-misc/freetype-2.4.9:2=
	xmedia-lib/jbig2dec
	>=xgui-misc/lcms-2.6:2
	>=xmedia-lib/libpng-1.6.2:0=
	>=xmedia-lib/openjpeg-2.1.0:2=
	>=lib-core/zlib-1.2.7:=
	xmedia-lib/libjpeg-turbo
	cups? ( >=lib-print/cups-1.3.8 )
	dbus? ( app-core/dbus )
	gtk? ( xgui-live-lib/gtk3 )
	tiff? ( >=xmedia-lib/tiff-4.0.1:0= )
	X? ( xgui-lib/libXt xgui-lib/libXext )
"

BDEPEND="app-dev/pkgconf"

src_prepare() {
	filter-flags -Wl,-z,defs

	default

	# remove internal copies of various libraries
	rm -rf "${S}"/cups/libs || die
	rm -rf "${S}"/expat || die
	rm -rf "${S}"/freetype || die
	rm -rf "${S}"/jbig2dec || die
	rm -rf "${S}"/jpeg{,xr} || die
	rm -rf "${S}"/lcms{,2} || die
	rm -rf "${S}"/libpng || die
	rm -rf "${S}"/tiff || die
	rm -rf "${S}"/zlib || die
	rm -rf "${S}"/openjpeg || die
	# remove internal CMaps (CMaps from poppler-data are used instead)
	rm -rf "${S}"/Resource/CMap || die

	if ! use gtk ; then
		sed -i -e "s:\$(GSSOX)::" \
			-e "s:.*\$(GSSOX_XENAME)$::" \
			"${S}"/base/unix-dll.mak || die "sed failed"
	fi

	# Force the include dirs to a neutral location.
	sed -i \
		-e "/^ZLIBDIR=/s:=.*:=${T}:" \
		configure.ac || die
	# Some files depend on zlib.h directly.  Redirect them. #573248
	# Also make sure to not define OPJ_STATIC to avoid linker errors due to
	# hidden symbols (https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=203327#c1)
	sed -i \
		-e '/^zlib_h/s:=.*:=:' \
		-e 's|-DOPJ_STATIC ||' \
		base/lib.mak || die

	# search path fix
	# put LDFLAGS after BINDIR, bug #383447
	sed -i -e "s:\$\(gsdatadir\)/lib:@datarootdir@/ghostscript/${PVM}/lib:" \
		-e "s:exdir=.*:exdir=@datarootdir@/doc/${PF}/examples:" \
		-e "s:docdir=.*:docdir=@datarootdir@/doc/${PF}/html:" \
		-e "s:GS_DOCDIR=.*:GS_DOCDIR=@datarootdir@/doc/${PF}/html:" \
		-e 's:-L$(BINDIR):& $(LDFLAGS):g' \
		"${S}"/Makefile.in "${S}"/base/*.mak || die "sed failed"

	cd "${S}" || die
	# remove incorrect symlink, bug 590384
	rm -f ijs/ltmain.sh || die
	eautoreconf

	cd "${S}/ijs" || die
	eautoreconf
}

src_configure() {
	local FONTPATH
	for path in \
		"${EPREFIX}"/usr/share/fonts/urw-fonts \
		"${EPREFIX}"/usr/share/fonts/Type1 \
		"${EPREFIX}"/usr/share/fonts \
		"${EPREFIX}"/usr/share/poppler/cMap/Adobe-CNS1 \
		"${EPREFIX}"/usr/share/poppler/cMap/Adobe-GB1 \
		"${EPREFIX}"/usr/share/poppler/cMap/Adobe-Japan1 \
		"${EPREFIX}"/usr/share/poppler/cMap/Adobe-Japan2 \
		"${EPREFIX}"/usr/share/poppler/cMap/Adobe-Korea1
	do
		FONTPATH="$FONTPATH${FONTPATH:+:}${EPREFIX}$path"
	done

	PKGCONFIG=$(type -P $(tc-getPKG_CONFIG)) \
	econf \
		--enable-dynamic \
		--enable-freetype \
		--enable-fontconfig \
		--enable-openjpeg \
		--disable-compile-inits \
		--with-drivers=ALL \
		--with-fontpath="$FONTPATH" \
		--with-ijs \
		--with-jbig2dec \
		--with-libpaper \
		$(use_enable cups) \
		$(use_enable dbus) \
		$(use_enable gtk) \
		$(use_with cups pdftoraster) \
		$(use_with tiff system-libtiff) \
		$(use_with X x)

	cd "${S}/ijs" || die
	econf \
		--enable-shared \
		$(use_enable static-libs static)
}

src_compile() {
	emake so all

	cd "${S}/ijs" || die
	emake
}

src_install() {
	emake DESTDIR="${D}" install-so install

	cd "${S}/ijs" || die
	emake DESTDIR="${D}" install

	use static-libs || find "${ED}" -name '*.la' -delete
	cleanup_install
}

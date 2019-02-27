# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools versionator flag-o-matic toolchain-funcs

DESCRIPTION="Ghostscript is an interpreter for the PostScript language and for PDF"
HOMEPAGE="http://ghostscript.com/"

MY_P=${P/-gpl}
PVM=$(get_version_component_range 1-2)
PVM_S=$(replace_all_version_separators "" ${PVM})

SRC_URI="https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${PVM_S}/${MY_P}.tar.xz"

LICENSE="AGPL-3 CPL-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="cups dbus gtk static-libs tiff X"

COMMON_DEPEND="
	app-text/libpaper
	lib-media/fontconfig
	>=lib-media/freetype-2.4.9:2=
	lib-media/jbig2dec
	>=lib-media/lcms-2.6:2
	>=lib-media/libpng-1.6.2:0=
	>=lib-media/openjpeg-2.1.0:2=
	>=lib-sys/zlib-1.2.7:=
	lib-media/libjpeg-turbo
	cups? ( >=lib-print/cups-1.3.8 )
	dbus? ( sys-app/dbus )
	gtk? ( x11-libs/gtk+ )
	tiff? ( >=lib-media/tiff-4.0.1:0= )
	X? ( x11-libs/libXt x11-libs/libXext )
"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
"

RDEPEND="${COMMON_DEPEND}
	>=app-text/poppler-data-0.4.5-r1"

S="${WORKDIR}/${MY_P}"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
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
	sed -i -e "s:\$\(gsdatadir\)/lib:@datarootdir@/ghostscript/${PVM}/lib64:" \
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
		--without-luratech \
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

	# move gsc to gs, bug #343447
	# gsc collides with gambit, bug #253064
	mv -f "${ED}"/usr/bin/{gsc,gs} || die

	cd "${S}/ijs" || die
	emake DESTDIR="${D}" install

	# rename the original cidfmap to cidfmap.GS
	mv "${ED}/usr/share/ghostscript/${PVM}/Resource/Init/cidfmap"{,.GS} || die

	# install the CMaps from poppler-data properly, bug #409361
	dosym ../../../poppler/cMaps "/usr/share/ghostscript/${PVM}/Resource/CMap"

	use static-libs || find "${ED}" -name '*.la' -delete
}

# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module systemd flag-o-matic git-r3 autotools

DESCRIPTION="Cups filters"
HOMEPAGE="https://wiki.linuxfoundation.org/openprinting/cups-filters"
EGIT_REPO_URI="https://github.com/OpenPrinting/cups-filters.git"

KEYWORDS="amd64 arm64"
LICENSE="MIT GPL-2"
SLOT="0"
IUSE="dbus ipp_autosetup jpeg ldap pclm pdf perl png static-libs test tiff"

RDEPEND="
	>=app-text/poppler-0.32:=[cxx,jpeg?,lcms,tiff?,utils]
	>=app-text/qpdf-3.0.2:=
	lib-dev/glib:2
	lib-media/fontconfig
	lib-media/freetype:2
	lib-media/lcms:2
	>=lib-print/cups-1.7.3
	!<=lib-print/cups-1.5.9999
	sys-devel/bc
	lib-sys/zlib
	dbus? ( sys-app/dbus )
	jpeg? ( lib-media/libjpeg-turbo )
	ldap? ( app-net/openldap )
	pclm? ( >=app-text/qpdf-7.0_beta1 )
	pdf? ( app-text/mupdf )
	perl? ( dev-lang/perl:= )
	png? ( lib-media/libpng:0= )
	>=app-text/ghostscript-gpl-9.09[cups]
	tiff? ( lib-media/tiff:0 )
"
DEPEND="${RDEPEND}
	test? ( fonts/dejavu )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--enable-imagefilters
		--localstatedir="${EPREFIX}"/var
		--with-browseremoteprotocols=DNSSD,CUPS
		--with-cups-rundir="${EPREFIX}"/run/cups
		--with-fontdir="fonts/conf.avail"
		--with-pdftops=pdftops
		--with-rcdir=no
		--without-php
		$(use_enable dbus)
		--enable-foomatic
		$(use_enable ipp_autosetup auto-setup-driverless)
		$(use_enable ldap)
		$(use_enable pclm)
		$(use_enable pdf mutool)
		--enable-ghostscript
		--enable-ijs
		$(use_enable static-libs static)
		--disable-avahi
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
	)
	econf "${myeconfargs[@]}"
}

src_compile() {
	default

	if use perl; then
		pushd "${S}/scripting/perl" > /dev/null
		perl-module_src_configure
		perl-module_src_compile
		popd > /dev/null
	fi
}

src_install() {
	default

	if use perl; then
		pushd "${S}/scripting/perl" > /dev/null
		perl-module_src_install
		perl_delete_localpod
		popd > /dev/null
	fi

	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die

	systemd_dounit "${S}/utils/cups-browsed.service"
}

src_test() {
	emake check
}

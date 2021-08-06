# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Cups filters"
HOMEPAGE="https://wiki.linuxfoundation.org/openprinting/cups-filters"
SRC_URI="http://www.openprinting.org/download/${PN}/${P}.tar.xz"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dbus jpeg ldap pclm pdf png static-libs tiff"

DEPEND="
	>=app-text/poppler-0.32:=[cxx,jpeg?,lcms,tiff?,utils]
	app-text/qpdf
	lib-dev/glib:2
	xmedia-live-lib/fontconfig
	xmedia-live-lib/freetype:2
	xmedia-live-lib/lcms:2
	lib-print/cups
	sys-devel/bc
	lib-core/zlib
	dbus? ( app-core/dbus )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	ldap? ( app-net/openldap )
	pclm? ( >=app-text/qpdf-7.0_beta1 )
	pdf? ( app-text/mupdf )
	png? ( xmedia-live-lib/libpng:0= )
	app-text/ghostscript-gpl[cups]
	tiff? ( xmedia-live-lib/tiff:0 )
	fonts/liberation-fonts
"

src_configure() {
	local myconf=(
		--enable-imagefilters
		--localstatedir="${EPREFIX}"/var
		--with-browseremoteprotocols=DNSSD,CUPS
		--with-cups-rundir="${EPREFIX}"/run/cups
		--with-pdftops=pdftops
		--with-rcdir=no
		--without-php
		$(use_enable dbus)
		--enable-foomatic
		$(use_enable ldap)
		$(use_enable pclm)
		$(use_enable pdf mutool)
		--enable-ghostscript
		$(use_enable static-libs static)
		--disable-avahi
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
		--with-test-font-path=/usr/share/fonts/liberation-fonts/LiberationMono-Regular.ttf
	)
	econf "${myconf[@]}"
}

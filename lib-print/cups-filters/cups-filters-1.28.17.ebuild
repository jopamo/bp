# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Cups filters"
HOMEPAGE="https://wiki.linuxfoundation.org/openprinting/cups-filters"
SRC_URI="https://github.com/OpenPrinting/cups-filters/releases/download/${PV}/${P}.tar.xz"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dbus jpeg ldap pclm pdf png static-libs tiff"

DEPEND="
	app-build/bc
	app-tex/ghostscript-gpl[cups]
	app-tex/poppler
	app-tex/qpdf
	fonts/fontconfig
	fonts/liberation-fonts
	lib-core/zlib
	lib-util/glib
	lib-print/cups
	xgui-misc/freetype
	xgui-misc/lcms
	dbus? ( app-core/dbus )
	jpeg? ( xmedia-lib/libjpeg-turbo )
	ldap? ( app-net/openldap )
	pclm? ( app-tex/qpdf )
	pdf? ( app-tex/mupdf )
	png? ( xmedia-lib/libpng )
	tiff? ( xmedia-lib/tiff )
"

src_configure() {
	append-flags -std=c++17

	local myconf=(
		--localstatedir="${EPREFIX}"/var
		--with-cups-rundir="${EPREFIX}"/run/cups
		$(use_enable dbus)
		$(use_enable ldap)
		$(use_enable pclm)
		$(use_enable pdf mutool)
		$(use_enable static-libs static)
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
		--disable-avahi
		--enable-foomatic
		--enable-ghostscript
		--enable-imagefilters
		--with-browseremoteprotocols=DNSSD,CUPS
		--with-pdftops=pdftops
		--with-rcdir=no
		--with-test-font-path=/usr/share/fonts/liberation-fonts/LiberationMono-Regular.ttf
		--without-php
	)
	econf "${myconf[@]}"
}

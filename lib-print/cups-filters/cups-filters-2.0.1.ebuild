# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Cups filters"
HOMEPAGE="https://wiki.linuxfoundation.org/openprinting/cups-filters"
SRC_URI="https://github.com/OpenPrinting/cups-filters/releases/download/${PV}/${P}.tar.xz"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="foomatic"

DEPEND="
	lib-print/cups
	lib-print/libppd
	lib-print/libcupsfilters
"

src_prepare() {
	default
	append-flags "-fpermissive -std=gnu17"
}

src_configure() {
	local myeconfargs=(
		--enable-imagefilters
		--enable-driverless
		--enable-poppler
		--localstatedir="${EPREFIX}"/var
		--with-fontdir="fonts/conf.avail"
		# cups-browsed is split out and avahi is not needed for filters
		# https://github.com/OpenPrinting/cups-filters/pull/558
		--disable-avahi
		# These are just probed for the path. Always enable them.
		--with-gs-path="${EPREFIX}"/usr/bin/gs
		--with-mutool-path="${EPREFIX}"/usr/bin/mutool

		$(use_enable foomatic)
	)

	CONFIG_SHELL="${BROOT}"/bin/bash econf "${myeconfargs[@]}"
}

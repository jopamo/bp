# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="an implementation of the utmpx.h family of functions"
HOMEPAGE="https://skarnet.org/software/utmps/"
SRC_URI="https://skarnet.org/software/utmps/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	append-flags -ffat-lto-objects

	local myconf=(
		--enable-shared
		--enable-static
		--disable-allstatic
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/lib
		--with-dynlib="${EPREFIX}"/usr/lib
	)

	econf "${myconf[@]}"
}


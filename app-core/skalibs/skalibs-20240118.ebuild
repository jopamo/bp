# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=83bcd1e5ed5eb5c4abc5154dae4dc6e133c8ddb4

DESCRIPTION="an implementation of the utmpx.h family of functions"
HOMEPAGE="https://skarnet.org/software/utmps/"
SRC_URI="https://skarnet.org/software/utmps/${P}.tar.gz"

SRC_URI="https://github.com/skarnet/skalibs/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	#sed -i -e "s/@@VERSION@@/${PV}/g" -- "${S}"/*.pc || die

}

src_configure() {
	mkdir -p "${ED}"/usr/lib/skalibs/sysdeps

	local myconf=(
		--enable-shared
		--disable-static
		--disable-allstatic
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/lib
		--with-dynlib="${EPREFIX}"/usr/lib
	)

	econf "${myconf[@]}"
}


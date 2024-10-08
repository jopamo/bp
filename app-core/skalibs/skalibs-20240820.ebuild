# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="an implementation of the utmpx.h family of functions"
HOMEPAGE="https://skarnet.org/software/utmps/"

SNAPSHOT=a7973043c92dc0f9d083e600142a47ce6dd1c9f6
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


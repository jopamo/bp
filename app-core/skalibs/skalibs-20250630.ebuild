# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="an implementation of the utmpx.h family of functions"
HOMEPAGE="https://skarnet.org/software/utmps/"
SNAPSHOT=5bc6d77b08b39f863a7d8767a588f839c19d3113
SRC_URI="https://github.com/skarnet/skalibs/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/skalibs-${SNAPSHOT}

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	#append-flags -ffat-lto-objects
	filter-flags -flto*
	filter-flags -Wl,-z,defs

	default
	#sed -i -e "s/@@VERSION@@/${PV}/g" -- "${S}"/*.pc || die

}

src_configure() {
	mkdir -p "${ED}"/usr/lib/skalibs/sysdeps

	local myconf=(
		--enable-pkgconfig
		--with-sysdep-devurandom=yes
		--with-sysdep-posixspawnearlyreturn=no
		--with-sysdep-procselfexe=/proc/self/exe

	)

	econf "${myconf[@]}"
}


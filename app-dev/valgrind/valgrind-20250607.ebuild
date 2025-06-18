# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="An open-source memory debugger for GNU/Linux"
HOMEPAGE="http://www.valgrind.org"
SNAPSHOT=67e6e1c4c2fa7847ab7cb14360814599520932c6
SRC_URI="https://github.com/1g4-mirror/valgrind/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	filter-flags -fomit-frame-pointer -fstack-protector*
	filter-flags -flto* -Wl,-z,defs

	sed -i -e "s:doc/valgrind:doc/${PF}:" docs/Makefile.am || die
	sed -i -e 's:-arch \(i386\|x86_64\)::g' Makefile.all.am || die

	eapply "${FILESDIR}"/${PN}-3.7.0-respect-flags.patch

	eapply_user
	eautoreconf
}

src_configure() {
	econf --enable-only64bit
}

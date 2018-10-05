# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic multilib

DESCRIPTION="An open-source memory debugger for GNU/Linux"
HOMEPAGE="http://www.valgrind.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://sourceware.org/git/valgrind.git"
	inherit git-r3
else
	SRC_URI="ftp://sourceware.org/pub/valgrind/${P}.tar.bz2"
fi

src_prepare() {
	sed -i -e "s:doc/valgrind:doc/${PF}:" docs/Makefile.am || die
	sed -i -e 's:-arch \(i386\|x86_64\)::g' Makefile.all.am || die

	eapply "${FILESDIR}"/${PN}-3.7.0-respect-flags.patch

	eapply_user
	eautoreconf
}

src_configure() {
	filter-flags -fomit-frame-pointer
	filter-flags -fstack-protector
	filter-flags -fstack-protector-all
	filter-flags -fstack-protector-strong

	econf --enable-only64bit
}

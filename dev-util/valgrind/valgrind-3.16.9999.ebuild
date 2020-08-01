# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="An open-source memory debugger for GNU/Linux"
HOMEPAGE="http://www.valgrind.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://sourceware.org/git/valgrind.git"
	EGIT_BRANCH="VALGRIND_$(ver_cut 1)_$(ver_cut 2)_BRANCH"
else
	SRC_URI="ftp://sourceware.org/pub/valgrind/${P}.tar.bz2"
fi

filter-flags -Wl,-z,defs -fomit-frame-pointer -fstack-protector\*

src_prepare() {
	sed -i -e "s:doc/valgrind:doc/${PF}:" docs/Makefile.am || die
	sed -i -e 's:-arch \(i386\|x86_64\)::g' Makefile.all.am || die

	eapply "${FILESDIR}"/${PN}-3.7.0-respect-flags.patch

	eapply_user
	eautoreconf
}

src_configure() {
	econf --enable-only64bit
}

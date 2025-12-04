# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SNAPSHOT=9c2b17fca7cfc9cbcdedca1c08e1cccfae9105a4
SRC_URI="https://github.com/gwsw/less/archive/${SNAPSHOT}.tar.gz -> less-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/less-${SNAPSHOT}"

LICENSE="|| ( GPL-3 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	virtual/curses
	lib-core/libpcre2
"

src_prepare() {
	make -f Makefile.aut distfiles
	default
	eautoreconf
}
src_configure() {
	local myconf=(
		--with-regex=pcre2
		--with-editor="${EPREFIX}"/usr/bin/vim
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

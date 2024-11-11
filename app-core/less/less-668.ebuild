# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SRC_URI="http://www.greenwoodsoftware.com/less/${P}.tar.gz"

LICENSE="|| ( GPL-3 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pcre"

DEPEND="
	virtual/curses
	pcre? ( lib-core/libpcre )
"

src_configure() {
	export ac_cv_lib_ncursesw_initscr=yes
	export ac_cv_lib_ncurses_initscr=no

	local myconf=(
		--with-regex=$(usex pcre pcre posix) \
		--with-editor="${EPREFIX}"/usr/bin/vim
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

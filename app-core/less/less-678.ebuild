# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SRC_URI="http://www.greenwoodsoftware.com/less/${P}.tar.gz"

LICENSE="|| ( GPL-3 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	virtual/curses
	lib-core/libpcre2
"

src_configure() {
	local myconf=(
		--with-regex=pcre2
		--with-editor="${EPREFIX}"/usr/bin/vim
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

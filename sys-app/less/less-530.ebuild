# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SRC_URI="http://www.greenwoodsoftware.com/less/${P}.tar.gz"

LICENSE="|| ( GPL-3 BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="pcre unicode"

DEPEND=">=app-misc/editor-wrapper-3
	>=lib-sys/ncurses-5.2:0=
	pcre? ( lib-dev/libpcre )"
RDEPEND="${DEPEND}"

src_configure() {
	export ac_cv_lib_ncursesw_initscr=$(usex unicode)
	export ac_cv_lib_ncurses_initscr=$(usex !unicode)
	econf \
		--with-regex=$(usex pcre pcre posix) \
		--with-editor="${EPREFIX}"/usr/libexec/editor
}

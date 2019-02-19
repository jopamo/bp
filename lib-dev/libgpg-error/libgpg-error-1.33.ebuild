# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libtool toolchain-funcs

DESCRIPTION="Contains error handling functions used by GnuPG software"
HOMEPAGE="http://www.gnupg.org/related_software/libgpg-error"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="common-lisp nls static-libs"

RDEPEND="nls? ( >=sys-devel/gettext-0-r1 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	default
	elibtoolize
}

src_configure() {
	ECONF_SOURCE="${S}" econf \
		CC_FOR_BUILD="$(tc-getBUILD_CC)" \
		--enable-threads \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_enable common-lisp languages)
}

src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}

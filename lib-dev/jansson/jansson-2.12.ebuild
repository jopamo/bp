# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
HOMEPAGE="http://www.digip.org/jansson/"
SRC_URI="http://www.digip.org/jansson/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

src_prepare() {
	default
	sed -ie 's/-Werror//' src/Makefile.am || die
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" \
	econf \
		$(use_enable static-libs static)
}

# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic

DESCRIPTION="Low-level cryptographic library"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="|| ( LGPL-3 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+gmp static-libs test aes"

DEPEND="gmp? ( >=lib-dev/gmp-5.0:0= )"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf \
		--libdir="${EPREFIX}"/usr/lib64 \
		$(use_enable gmp public-key) \
		$(use_enable static-libs static) \
		--enable-fat \
		$(use_enable aes x86-aesni) \
		$(tc-is-static-only && echo --disable-shared) \
		--disable-documentation
}

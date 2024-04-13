# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Low-level cryptographic library"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"

SNAPSHOT=775d6adb77a885616ef3a9fcbc4c087cad129f3d
SRC_URI="https://github.com/gnutls/nettle/archive/${SNAPSHOT}.tar.gz -> nettle-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/nettle-${SNAPSHOT}"

LICENSE="|| ( LGPL-3 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+gmp static-libs test"

DEPEND="gmp? ( lib-core/gmp )"

src_prepare() {
	default

	sed -e '/CFLAGS=/s: -ggdb3::' \
		-i configure.ac || die

	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable gmp public-key)
		$(use_enable static-libs static)
		$(tc-is-static-only && echo --disable-shared)
		--disable-documentation
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

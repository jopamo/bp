# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools flag-o-matic

DESCRIPTION="C library providing BLAKE2b, BLAKE2s, BLAKE2bp, BLAKE2sp"
HOMEPAGE="https://github.com/BLAKE2/libb2"
EGIT_REPO_URI="https://github.com/BLAKE2/libb2.git"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static native-cflags"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	sed -i -e 's/ == / = /' configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static) \
		$(use_enable native-cflags native)
}

src_compile() {
	emake $(use native-cflags && echo no)CFLAGS="${CFLAGS}"
}

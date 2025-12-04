# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Extremely fast non-cryptographic hash algorithm"
HOMEPAGE="http://www.xxhash.net"
SNAPSHOT=7b2c67f3d1d940aca00a4df895b7f97062dd8cc4
SRC_URI="https://github.com/Cyan4973/xxHash/archive/${SNAPSHOT}.tar.gz -> xxHash-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xxHash-${SNAPSHOT}"

LICENSE="BSD-2 GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_compile() {
	append-flags -ffat-lto-objects
	PREFIX="${EPREFIX}/usr" \
	LIBDIR="${EPREFIX}/usr/lib" \
	emake AR="$(tc-getAR)" CC="$(tc-getCC)"
}

src_install() {
	PREFIX="${EPREFIX}/usr" \
	LIBDIR="${EPREFIX}/usr/lib" \
	MANDIR="${EPREFIX}/usr/share/man/man1" \
	emake DESTDIR="${D}" install

	if ! use static-libs ; then
		rm "${ED}"/usr/lib/libxxhash.a || die
	fi

	rm "${ED}"/usr/share/man/man1/xxh32sum.1 || die
	rm "${ED}"/usr/share/man/man1/xxh64sum.1 || die
	rm "${ED}"/usr/share/man/man1/xxh128sum.1 || die
}

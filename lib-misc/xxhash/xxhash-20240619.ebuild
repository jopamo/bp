# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Extremely fast non-cryptographic hash algorithm"
HOMEPAGE="http://www.xxhash.net"

SNAPSHOT=805c00b68fa754200ada0c207ffeaa7a4409377c
SRC_URI="https://github.com/Cyan4973/xxHash/archive/${SNAPSHOT}.tar.gz -> xxHash-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xxHash-${SNAPSHOT}"

LICENSE="BSD-2 GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_compile() {
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

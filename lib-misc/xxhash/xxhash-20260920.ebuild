# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs flag-o-matic qa-policy

DESCRIPTION="Extremely fast non-cryptographic hash algorithm"
HOMEPAGE="http://www.xxhash.net"
SNAPSHOT=680bf463fa1ca0461b9a7c2dab7556e1f54cf4cf
SRC_URI="https://github.com/Cyan4973/xxHash/archive/${SNAPSHOT}.tar.gz -> xxHash-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xxHash-${SNAPSHOT}"

LICENSE="BSD-2 GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_compile() {
	qa-policy-configure
	PREFIX="${EPREFIX}/usr" \
	LIBDIR="${EPREFIX}/usr/lib" \
	emake AR="$(tc-getAR)" CC="$(tc-getCC)"
}

src_install() {
	PREFIX="${EPREFIX}/usr" \
	LIBDIR="${EPREFIX}/usr/lib" \
	MANDIR="${EPREFIX}/usr/share/man/man1" \
	emake DESTDIR="${D}" install

	qa-policy-install

	if ! use static-libs ; then
		rm "${ED}"/usr/lib/libxxhash.a || die
	fi

	rm "${ED}"/usr/share/man/man1/xxh32sum.1 || die
	rm "${ED}"/usr/share/man/man1/xxh64sum.1 || die
	rm "${ED}"/usr/share/man/man1/xxh128sum.1 || die
}

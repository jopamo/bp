# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="zstd fast compression library"
HOMEPAGE="https://facebook.github.io/zstd/"

SNAPSHOT=0e2ceb2d5061f3a8357d124029ebaae16d915a3d
SRC_URI="https://github.com/facebook/zstd/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-compression/xz-utils"

append-flags -Wa,--noexecstack

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${EPREFIX}"/usr/lib zstd

	emake -C lib \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${EPREFIX}"/usr/lib libzstd

	emake -C contrib/pzstd \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${EPREFIX}"/usr/lib

}

src_install() {
	emake \
		DESTDIR="${ED}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${EPREFIX}"/usr/lib install

	emake -C contrib/pzstd \
		DESTDIR="${ED}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${EPREFIX}"/usr/lib install

	if ! use static-libs; then
		rm "${ED}"/usr/lib/libzstd.a || die
	fi
}

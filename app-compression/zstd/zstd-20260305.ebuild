# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs flag-o-matic qa-policy

DESCRIPTION="zstd fast compression library"
HOMEPAGE="https://facebook.github.io/zstd/"
SNAPSHOT=d7ee3207cc0db53f78fc6a69babc80747b1b7658
SRC_URI="https://github.com/facebook/zstd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/zstd-${SNAPSHOT}

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-compression/xz-utils"

src_compile() {
	qa-policy-configure
	local libdir="${EPREFIX}/usr/lib"

	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}" zstd

	emake -C lib \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}" libzstd

	emake -C contrib/pzstd \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}"

}

src_install() {
	local libdir="${EPREFIX}/usr/lib"

	emake \
		DESTDIR="${ED}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}" install

	emake -C contrib/pzstd \
		DESTDIR="${ED}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}" install

	if ! use static-libs; then
		rm "${ED}${libdir}"/libzstd.a || die
	fi

	qa-policy-install
}

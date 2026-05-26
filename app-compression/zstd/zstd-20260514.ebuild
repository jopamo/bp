# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs flag-o-matic qa-policy

DESCRIPTION="zstd fast compression library"
HOMEPAGE="https://facebook.github.io/zstd/"
SNAPSHOT=5233c58e6ca0b1c4c6b353ad79649191ed195bdc
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
	local ar=$(tc-getAR)
	local ranlib=$(tc-getRANLIB)
	local nm=$(tc-getNM)

	emake \
		CC="$(tc-getCC)" \
		AR="${ar}" \
		RANLIB="${ranlib}" \
		NM="${nm}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}" zstd

	emake -C lib \
		CC="$(tc-getCC)" \
		AR="${ar}" \
		RANLIB="${ranlib}" \
		NM="${nm}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}" libzstd

	emake -C contrib/pzstd \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		AR="${ar}" \
		RANLIB="${ranlib}" \
		NM="${nm}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}"

}

src_install() {
	local libdir="${EPREFIX}/usr/lib"
	local ar=$(tc-getAR)
	local ranlib=$(tc-getRANLIB)
	local nm=$(tc-getNM)

	emake \
		AR="${ar}" \
		DESTDIR="${ED}" \
		RANLIB="${ranlib}" \
		NM="${nm}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}" install

	emake -C contrib/pzstd \
		AR="${ar}" \
		DESTDIR="${ED}" \
		RANLIB="${ranlib}" \
		NM="${nm}" \
		PREFIX="${EPREFIX}"/usr \
		LIBDIR="${libdir}" install

	if ! use static-libs; then
		rm "${ED}${libdir}"/libzstd.a || die
	fi

	qa-policy-install
}

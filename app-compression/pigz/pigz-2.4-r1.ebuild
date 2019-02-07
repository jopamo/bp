# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A parallel implementation of gzip"
HOMEPAGE="http://www.zlib.net/pigz/"
SRC_URI="http://www.zlib.net/pigz/${P}.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static test"

LIB_DEPEND="lib-sys/zlib[static-libs(+)]"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

PATCHES=(
		${FILESDIR}/1a8e39b8aa275b5405616c4f2d6750374bd098b5.patch
		${FILESDIR}/176b3abf3acd153cc522b739dde55cbcc077ed0d.patch
		${FILESDIR}/43752cc2e4c455d24327ec02dfef7f1618e6849f.patch
		${FILESDIR}/5b86ed0f203a76d33eaf0c4cde29ae59c49a4254.patch
		${FILESDIR}/13c1f55f00c820885bde90c024b6d55346055e41.patch
)

src_compile() {
	use static && append-ldflags -static
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	dosym ${PN} /usr/bin/gzip
	dosym ${PN} /usr/bin/gunzip
	dosym ${PN} /usr/bin/zcat
}

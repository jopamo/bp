# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A parallel implementation of gzip"
HOMEPAGE="http://www.zlib.net/pigz/"

SNAPSHOT=9696c84cb1963651707e649978afb07d0c11b254
SRC_URI="https://github.com/madler/pigz/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test"

DEPEND="static? ( lib-sys/zlib[static-libs(+)] )"

src_compile() {
	use static && append-ldflags -static
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}

	for x in gzip gunzip zcat ; do
		dosym ${PN} usr/bin/${x}
	done
}

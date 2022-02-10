# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A parallel implementation of gzip"
HOMEPAGE="http://www.zlib.net/pigz/"

SNAPSHOT=e1fa51ca99a851febe2b00632f3ba417d30f8a6c
SRC_URI="https://github.com/madler/pigz/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test"

DEPEND="static? ( lib-core/zlib[static-libs(+)] )"

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

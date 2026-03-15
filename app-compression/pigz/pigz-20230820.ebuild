# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qa-policy toolchain-funcs

DESCRIPTION="A parallel implementation of gzip"
HOMEPAGE="https://www.zlib.net/pigz/"

SNAPSHOT=fe4894f57739e3039a2ffc2a2a360d35e19bacbe
SRC_URI="https://github.com/madler/pigz/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/pigz-${SNAPSHOT}

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static test"

DEPEND="
	lib-core/zlib
	static? ( lib-core/zlib[static-libs(+)] )
	test? ( app-compression/gzip )
"
RDEPEND="
	lib-core/zlib:=
"

src_configure() {
	qa-policy-configure
}

src_compile() {
	use static && append-ldflags -static
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_test() {
	emake test
}

src_install() {
	dobin pigz

	for x in gzip gunzip zcat ; do
		dosym -r /usr/bin/pigz /usr/bin/${x}
	done

	qa-policy-install
}

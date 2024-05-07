# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=20aad26c59cb96a729ea26dbf53459f60da94db9

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Lists open files for running Unix processes"
HOMEPAGE="ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/"
SRC_URI="https://github.com/lsof-org/lsof/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="lsof"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

src_prepare() {
	default
	sed -i 's|/\* #define\tHASSECURITY\t1 \*/|#define\tHASSECURITY\t1|' dialects/linux/machine.h
	sed -i "s|.so ./version|.ds VN ${PV}|" -i Lsof.8
}

src_configure() {
	filter-flags -flto*

	use static && append-ldflags -static

	./Configure -n linux || die
}

src_compile() {
	emake DEBUG="" CC="cc ${CFLAGS} ${CPPFLAGS} ${LDFLAGS}"

}

src_install() {
	dobin lsof
	newman Lsof.8 lsof.8
}

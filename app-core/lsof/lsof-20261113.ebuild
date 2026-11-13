# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=c08c6ac4319e346b406cb5072aa68e0adf6a83da

inherit flag-o-matic

DESCRIPTION="Lists open files for running Unix processes"
HOMEPAGE="ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/"
SRC_URI="https://github.com/lsof-org/lsof/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lsof-${SNAPSHOT}

LICENSE="lsof"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

PATCHES=( "${FILESDIR}/lsof-tests-noninteractive-ci.patch" )

src_prepare() {
	default
	sed -i 's|/\* #define\tHASSECURITY\t1 \*/|#define\tHASSECURITY\t1|' \
		lib/dialects/linux/machine.h || die
	grep -q '^#define[[:space:]]*HASSECURITY[[:space:]]*1$' \
		lib/dialects/linux/machine.h || die "HASSECURITY was not enabled"
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

src_test() {
	CI=1 default
}

src_install() {
	dobin lsof
	newman Lsof.8 lsof.8
}

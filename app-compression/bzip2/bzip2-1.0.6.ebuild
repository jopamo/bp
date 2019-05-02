# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic

DESCRIPTION="a high-quality data compressor."
HOMEPAGE="http://sources.redhat.com/bzip2"
SRC_URI="https://ftp.osuosl.org/pub/lfs/lfs-packages/8.1/${P}.tar.gz"
LICENSE="BZIP2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

filter-flags -flto

src_prepare() {
	default

	sed -i "s|-O2|${CFLAGS}|g" Makefile
	sed -i "s|-O2|${CFLAGS}|g" Makefile-libbz2_so
}

src_compile() {
	use static-libs && emake
	emake -f Makefile-libbz2_so
}

src_install() {
	dolib.so libbz2.so.1.0.6
	dosym libbz2.so.1.0.6 usr/lib64/libbz2.so.1
	dosym libbz2.so.1.0.6 usr/lib64/libbz2.so.1.0
	use static-libs && dolib.a libbz2.a

	insinto /usr/include
	doins bzlib.h
}

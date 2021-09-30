# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="a high-quality data compressor."
HOMEPAGE="https://sourceware.org/bzip2/"
SRC_URI="https://sourceware.org/pub/bzip2/${P}.tar.gz"

LICENSE="BZIP2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

PATCHES=( "${FILESDIR}"/8ca1faa31f396d94ab927b257f3a05236c84e330.patch )

filter-flags -flto\=\*

src_prepare() {
	use static-libs && filter-flags -flto\=\*

	default

	sed -i "s|-O2|${CFLAGS}|g" Makefile
	sed -i "s|-O2|${CFLAGS}|g" Makefile-libbz2_so
}

src_compile() {
	use static-libs && emake

	emake -f Makefile-libbz2_so
	emake bzip2 bzip2recover
}

src_install() {
	newbin bzip2-shared bzip2

	for x in bzip2recover bzdiff bzgrep bzmore ; do
		dobin ${x}
	done

	for x in bunzip2 bzcat ; do
		dosym -r /usr/bin/bzip2 /usr/bin/${x}
	done

	dolib.so libbz2.so.${PV}

	for x in libbz2.so.1 libbz2.so.1.0 libbz2.so ; do
		dosym -r /usr/lib/libbz2.so.${PV} /usr/lib/${x}
	done

	use static-libs && dolib.a libbz2.a

	insinto /usr/include
	doins bzlib.h

	insinto /usr/lib/pkgconfig
	doins "${FILESDIR}"/bzip2.pc
}

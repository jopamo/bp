# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic toolchain-funcs qa-policy

MAINPV=1.0.8

DESCRIPTION="a high-quality data compressor"
HOMEPAGE="https://sourceware.org/bzip2/"
SNAPSHOT=af79253677ad98d6dfe11ea315ee9947d86586d3
SRC_URI="https://github.com/1g4-mirror/bzip2/archive/${SNAPSHOT}.tar.gz -> bzip2-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/bzip2-${SNAPSHOT}"

LICENSE="BZIP2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	local compiler

	filter-flags -flto*

	default

	compiler=$(tc-getCC)
	sed -i "s|-O2|${CFLAGS}|g" Makefile || die
	sed -i "s|-O2|${CFLAGS}|g" Makefile-libbz2_so || die
	sed -i "s|gcc|${compiler}|g" Makefile || die
	sed -i "s|gcc|${compiler}|g" Makefile-libbz2_so || die
}

src_compile() {
	qa-policy-configure
	use static-libs && emake

	emake -f Makefile-libbz2_so
	emake bzip2 bzip2recover
}

src_install() {
	local libdir="/usr/lib"

	newbin bzip2-shared bzip2

	for x in bzip2recover bzdiff bzgrep bzmore ; do
		dobin ${x}
	done

	for x in bunzip2 bzcat ; do
		dosym -r /usr/bin/bzip2 /usr/bin/${x}
	done

	dolib.so libbz2.so.${MAINPV}

	for x in libbz2.so.1 libbz2.so.1.0 libbz2.so ; do
		dosym -r "${libdir}/libbz2.so.${MAINPV}" "${libdir}/${x}"
	done

	if use static-libs ; then
		dolib.a libbz2.a
	fi

	insinto /usr/include
	doins bzlib.h

	insinto "${libdir}/pkgconfig"
	doins "${FILESDIR}"/bzip2.pc

	qa-policy-install
}

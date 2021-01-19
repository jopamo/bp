# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic autotools

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"
SRC_URI="https://sourceware.org/elfutils/ftp/${PV}/${P}.tar.bz2"

LICENSE="|| ( GPL-2+ LGPL-3+ ) utils? ( GPL-3+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 lzma musl nls static-libs test +utils valgrind"

RDEPEND=">=lib-sys/zlib-1.2.8-r1
	bzip2? ( >=app-compression/lbzip2-1.0.6-r4 )
	lzma? ( >=app-compression/xz-utils-5.0.5-r1 )
	musl? (
		lib-sys/argp-standalone
		lib-sys/musl-fts
		lib-sys/musl-obstack
	)
	>=sys-devel/flex-2.5.4a
	sys-devel/m4"

filter-flags -flto\=\*

src_prepare() {
	default

	use musl && eapply "${FILESDIR}"/${PN}-0.175-disable-biarch-test-PR24158.patch
	use musl && eapply "${FILESDIR}"/${PN}-0.177-disable-large.patch
	use musl && eapply "${FILESDIR}"/${PN}-0.180-PaX-support.patch
	use musl && eapply "${FILESDIR}"/${PN}-0.179-CC-in-tests.patch
	use musl && eapply "${FILESDIR}"/${PN}-0.180-readelf.patch

	# Musl Patches
	use musl && eapply "${FILESDIR}"/0.178/fix-aarch64_fregs.patch
	use musl && eapply "${FILESDIR}"/0.178/musl-asm_ptrace_h.patch
	use musl && eapply "${FILESDIR}"/0.178/musl-cdefs.patch
	use musl && eapply "${FILESDIR}"/0.178/musl-macros.patch
	use musl && eapply "${FILESDIR}"/0.178/musl-fts-obstack.patch
	use musl && eapply "${FILESDIR}"/0.178/musl-qsort_r.patch
	use musl && eapply "${FILESDIR}"/0.178/musl-strerror_r.patch
	use musl && eapply "${FILESDIR}"/0.178/musl-strndupa.patch
	use musl && eapply "${FILESDIR}"/0.178/musl-error_h.patch

	eautoreconf

	if ! use static-libs; then
		sed -i -e '/^lib_LIBRARIES/s:=.*:=:' -e '/^%.os/s:%.o$::' lib{asm,dw,elf}/Makefile.in || die
	fi
	# https://sourceware.org/PR23914
	sed -i 's:-Werror::' */Makefile.in || die

	if use musl; then
		cat > lib/libintl.h <<-EOF
			#ifndef LIBINTL_H
			#define LIBINTL_H
			#define _(x) (x)
			#endif
		EOF
	fi
}

src_configure() {
	use test && append-flags -g #407135

	# Symbol aliases are implemented as asm statements.
	# Will require porting: https://gcc.gnu.org/PR48200
	filter-flags '-flto*'

	src_configure
}

src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable nls) \
		$(use_enable valgrind) \
		--disable-debuginfod \
		--program-prefix="eu-" \
		--with-zlib \
		$(use_with bzip2 bzlib) \
		$(use_with lzma)
}

src_test() {
	# CC is a workaround for tests using ${CC-gcc}
	env	LD_LIBRARY_PATH="${BUILD_DIR}/libelf:${BUILD_DIR}/libebl:${BUILD_DIR}/libdw:${BUILD_DIR}/libasm" \
		LC_ALL="C" \
		CC="$(tc-getCC)" \
		emake check VERBOSE=1
}

src_install() {
	default

	if ! use utils; then
		rm -rf "${ED}"/usr/bin || die
	fi
}

# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic autotools

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"
SRC_URI="https://sourceware.org/elfutils/ftp/${PV}/${P}.tar.bz2"

LICENSE="|| ( GPL-2+ LGPL-3+ ) utils? ( GPL-3+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 lzma musl static-libs test +utils valgrind"

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

	if use musl; then
		eapply "${FILESDIR}"/fix-uninitialized.patch
		eapply "${FILESDIR}"/musl-fts-obstack.patch
		eapply "${FILESDIR}"/musl-qsort_r.patch
		eapply "${FILESDIR}"/musl-strndupa.patch
		eapply "${FILESDIR}"/fix-aarch64_fregs.patch
		eapply "${FILESDIR}"/musl-asm-ptrace-h.patch
		eapply "${FILESDIR}"/musl-macros.patch
		eapply "${FILESDIR}"/musl-strerror_r.patch
	fi

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
	local myconf=(
		$(use_enable valgrind)
		$(use_with bzip2 bzlib)
		$(use_with lzma)
		--enable-deterministic-archives
		--disable-nls
		--disable-libdebuginfod
		--disable-debuginfod
		--program-prefix="eu-"
		--with-zlib
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
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

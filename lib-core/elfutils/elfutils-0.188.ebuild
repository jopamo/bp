# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"
SRC_URI="https://sourceware.org/elfutils/ftp/${PV}/${P}.tar.bz2"

LICENSE="|| ( GPL-2+ LGPL-3+ ) utils? ( GPL-3+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 lzma musl static-libs test +utils valgrind zstd"

DEPEND="
	lib-core/zlib
	bzip2? ( app-compression/bzip2 )
	lzma? ( app-compression/xz-utils )
	musl? (
		lib-core/argp-standalone
		lib-core/musl-fts
		lib-core/musl-obstack
		app-build/musl-headers
	)
	zstd? ( app-compression/zstd )
	app-build/flex
	app-build/m4
"

filter-flags -flto\=\*

src_prepare() {
	default

	if use musl; then
		eapply "${FILESDIR}"/fix-uninitialized.patch
		eapply "${FILESDIR}"/musl-strndupa.patch
		eapply "${FILESDIR}"/fix-aarch64_fregs.patch
		eapply "${FILESDIR}"/musl-asm-ptrace-h.patch
		eapply "${FILESDIR}"/musl-macros.patch

		cp "${FILESDIR}"/error.h lib/

		cat > lib/libintl.h <<-EOF
			#ifndef LIBINTL_H
			#define LIBINTL_H
			#define _(x) (x)
			#endif
		EOF
	fi

	# https://sourceware.org/PR23914
	sed -i 's:-Werror::' */Makefile.in || die
}

src_configure() {
	local myconf=(
		$(use_enable valgrind)
		$(use_with bzip2 bzlib)
		$(use_with lzma)
		$(use_with zstd)
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

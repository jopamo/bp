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
	elibc_musl? (
		lib-core/argp-standalone
		lib-core/musl-bsd
	)
	zstd? ( app-compression/zstd )
	app-build/flex
	app-build/m4
"

src_prepare() {
	filter-flags -flto*

	default

	if use musl; then
		eapply "${FILESDIR}"/fix-uninitialized.patch
		eapply "${FILESDIR}"/musl-strndupa.patch
		eapply "${FILESDIR}"/fix-aarch64_fregs.patch
		eapply "${FILESDIR}"/musl-asm-ptrace-h.patch
		eapply "${FILESDIR}"/musl-macros.patch

		cp "${FILESDIR}"/error.h lib/

		cat > lib/libintl.h <<-EOF
			#ifndef DUMMY_LIBINTL_H
		#define DUMMY_LIBINTL_H

		/* No-op versions of gettext-related functions. */

		static inline const char *
		gettext(const char *msgid)
		{
    		return msgid;
		}

		static inline const char *
		dgettext(const char *domain, const char *msgid)
		{
    		return msgid;
		}

		static inline const char *
		dcgettext(const char *domain, const char *msgid, int category)
		{
    		return msgid;
		}

		static inline const char *
		ngettext(const char *msgid_singular,
         		const char *msgid_plural,
         		unsigned long int n)
		{
    		return (n == 1 ? msgid_singular : msgid_plural);
		}

		/* Likewise make bindtextdomain, textdomain, etc. do nothing. */
		static inline const char *
		bindtextdomain(const char *domainname, const char *dirname)
		{
    		return dirname;  /* Just return what was passed in */
		}

		static inline const char *
		textdomain(const char *domainname)
		{
    		return domainname;  /* Just return what was passed in */
		}

		#endif /* DUMMY_LIBINTL_H */
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

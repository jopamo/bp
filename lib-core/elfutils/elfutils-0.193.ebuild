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
		eapply "${FILESDIR}"/fix-aarch64_fregs.patch

		cat > lib/libintl.h <<-EOF
		#ifndef _DUMMY_LIBINTL_H
		#define _DUMMY_LIBINTL_H 1

		#include <sys/cdefs.h>

		#ifndef gettext
		# define gettext(msgid) \
    		((char *)(msgid))
		#endif

		#ifndef dgettext
		# define dgettext(domain, msgid) \
    		((char *)(msgid))
		#endif

		#ifndef dcgettext
		# define dcgettext(domain, msgid, category) \
    		((char *)(msgid))
		#endif

		#ifndef ngettext
		# define ngettext(msgid_singular, msgid_plural, n) \
    		((char *)((n) == 1 ? (msgid_singular) : (msgid_plural)))
		#endif

		#ifndef dngettext
		# define dngettext(domain, msgid_singular, msgid_plural, n) \
    		((char *)((n) == 1 ? (msgid_singular) : (msgid_plural)))
		#endif

		#ifndef dcngettext
		# define dcngettext(domain, msgid_singular, msgid_plural, n, category) \
    		((char *)((n) == 1 ? (msgid_singular) : (msgid_plural)))
		#endif

		#ifndef textdomain
		# define textdomain(domainname) \
    		((char *)"messages")
		#endif

		#ifndef bindtextdomain
		# define bindtextdomain(domainname, dirname) \
    		((char *)(dirname))
		#endif

		#ifndef bind_textdomain_codeset
		# define bind_textdomain_codeset(domainname, codeset) \
    		((char *)(codeset))
		#endif

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

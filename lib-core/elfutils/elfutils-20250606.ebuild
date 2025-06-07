# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"

SNAPSHOT=3cc287a29294bec86380a93020de71d8e8c636ac
SRC_URI="https://github.com/1g4-mirror/elfutils/archive/${SNAPSHOT}.tar.gz -> elfutils-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/elfutils-${SNAPSHOT}

LICENSE="|| ( GPL-2+ LGPL-3+ ) utils? ( GPL-3+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 debuginfod debugpred demangler
gcov gnu-ld gprof helgrind +install-elfh libdebuginfod lzma musl rpath sanitize-address
sanitize-memory sanitize-undefined stacktrace static-libs symbol-versioning test
tests-rpath textrelcheck +utils valgrind with_valgrind year2038 zlib zstd"

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
	sed -i 's:-Werror::' */Makefile.am || die

	eautoreconf
}

src_configure() {
	local myconf=(
		#$(use_enable sanitize-memory)
		#$(use_enable sanitize-undefined)
		#$(use_enable sanitize-address)
		#$(use_enable debugpred)
		#$(use_enable gprof)
		#$(use_enable gcov)
		#$(use_enable helgrind)
		#$(use_enable valgrind)
		#$(use_enable valgrind valgrind-annotations)
		#$(use_enable install-elfh)
		#$(use_enable stacktrace)
		#$(use_enable year2038)
		#$(use_enable libdebuginfod)
		#$(use_enable debuginfod)
		#$(use_with with_valgrind valgrind)
		$(use_with bzip2 bzlib)
		$(use_with lzma)
		$(use_with zstd)
		#$(use_with gnu-ld)
		--enable-deterministic-archives
		#$(use_disable largefile)
		#$(use_disable demangler)
		#$(use_disable textrelcheck)
		#$(use_disable symbol-versioning)
		--disable-nls
		--disable-rpath
		--enable-maintainer-mode
		$(use_with zlib)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
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

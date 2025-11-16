# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Libraries/utilities to handle ELF objects (drop in replacement for libelf)"
HOMEPAGE="http://elfutils.org/"
SNAPSHOT=d5987fcafa5dec3d900695afa6841cef98e1e0c4
SRC_URI="https://github.com/1g4-mirror/elfutils/archive/${SNAPSHOT}.tar.gz -> elfutils-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/elfutils-${SNAPSHOT}

LICENSE="|| ( GPL-2+ LGPL-3+ ) utils? ( GPL-3+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 debuginfod debugpred demangler gcov gnu-ld gprof helgrind largefile
libdebuginfod lzma rpath sanitize-address sanitize-memory sanitize-undefined
stacktrace static-libs symbol-versioning test tests-rpath textrelcheck +utils
valgrind with_valgrind year2038 zlib zstd
"

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
	append-flags -Wno-error
	append-flags -Werror=unused-value

	default

	if use elibc_musl; then
		eapply "${FILESDIR}"/fix-aarch64_fregs.patch
		eapply "${FILESDIR}"/musl-macros.patch
	fi

	# https://sourceware.org/PR23914
	sed -i 's:-Werror::' */Makefile.am || die

	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable demangler)
		$(use_enable largefile)
		$(use_enable symbol-versioning)
		$(use_enable textrelcheck)
		$(use_enable debuginfod)
		$(use_enable debugpred)
		$(use_enable gcov)
		$(use_enable gprof)
		$(use_enable helgrind)
		$(use_enable libdebuginfod)
		$(use_enable sanitize-address)
		$(use_enable sanitize-memory)
		$(use_enable sanitize-undefined)
		$(use_enable stacktrace)
		$(use_enable tests-rpath tests-rpath)
		$(use_enable valgrind valgrind-annotations)
		$(use_enable valgrind)
		$(use_enable year2038)
		$(use_with bzip2 bzlib)
		$(use_with gnu-ld)
		$(use_with lzma)
		$(use_with with_valgrind valgrind)
		$(use_with zlib)
		$(use_with zstd)
		--disable-nls
		--disable-rpath
		--enable-deterministic-archives
		--enable-maintainer-mode
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

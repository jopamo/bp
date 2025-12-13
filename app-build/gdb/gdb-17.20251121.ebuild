# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gdb-$(ver_cut 1)-branch"

PYTHON_COMPAT=( python3_12 )

inherit flag-o-matic python-single-r1 toolchain-funcs

DESCRIPTION="GNU debugger"
HOMEPAGE="https://sourceware.org/gdb/"
SNAPSHOT=025ff2ac593a82520952bbe539edfe5b0931e961
SRC_URI="https://github.com/1g4-mirror/binutils-gdb/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/binutils-gdb-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="client lzma multitarget python server test xml"

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
	|| ( client server )
"

RDEPEND="
	server? ( !app-dev/gdbserver )
	client? (
		virtual/curses
		lib-core/readline
		lzma? ( app-compression/xz-utils )
		python? ( ${PYTHON_DEPS} )
		xml? ( lib-core/expat )
		lib-core/zlib
	)
"
DEPEND="
	${RDEPEND}
	app-compression/xz-utils
	lib-misc/xxhash
	app-build/texinfo
	client? (
		app-build/bison
		test? ( app-dev/dejagnu )
	)
"

GDB_BUILD_DIR="${WORKDIR}/${P}-build"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default
	use elibc_musl && eapply "${FILESDIR}"/termios.patch
}

src_configure() {
	strip-flags
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"
	append-flags -fpermissive

	local myconf=(
		$(use multitarget && echo --enable-targets=all)
		$(use_enable server gdbserver auto)
		$(usex client '' '--disable-gdb')
		$(use_with lzma)
		$(use_with python python "${EPYTHON}")
		$(use_with xml expat)
		--disable-dependency-tracking
		--disable-install-libbfd
		--disable-install-libiberty
		--disable-werror
		--disable-{binutils,etc,gas,gold,gprof,gprofng,ld}
		--enable-64-bit-bfd
		--enable-tui
		--with-separate-debug-dir="${EPREFIX}"/usr/lib/debug
		--with-system-readline
		--with-system-zlib
		--without-guile
	)

	export ac_cv_path_pkg_config_prog_path="$(tc-getPKG_CONFIG)"

	mkdir "${GDB_BUILD_DIR}" || die
	pushd "${GDB_BUILD_DIR}" >/dev/null || die
		ECONF_SOURCE=${S} econf "${myconf[@]}"
	popd >/dev/null
}

src_compile() {
	emake -C "${GDB_BUILD_DIR}"
}

src_test() {
	use test || return 0
	emake -C "${GDB_BUILD_DIR}" check
}

src_install() {
	if use server && ! use client; then
		emake -C "${GDB_BUILD_DIR}"/gdb/gdbserver DESTDIR="${D}" install
	else
		emake -C "${GDB_BUILD_DIR}" DESTDIR="${D}" install
	fi

	if use client; then
		find "${ED}"/usr -name libiberty.a -delete || die
	fi

	# Remove shared info pages
	rm "${ED}"/usr/share/info/{annotate,bfd,ctf-spec,sframe-spec}.info* || die

	if use python; then
		python_optimize "${ED}"/usr/share/gdb/python/gdb
	fi

	cleanup_install
}

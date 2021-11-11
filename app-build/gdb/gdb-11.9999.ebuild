# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic python-single-r1 git-r3

DESCRIPTION="GNU debugger"
HOMEPAGE="https://sourceware.org/gdb/"
EGIT_REPO_URI="https://github.com/bminor/binutils-gdb.git"
EGIT_BRANCH="gdb-$(ver_cut 1)-branch"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+client lzma multitarget +python +server test vanilla xml"

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
	)"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	app-build/texinfo
	client? (
		app-build/bison
		test? ( app-dev/dejagnu )
	)"

GDB_BUILD_DIR="${WORKDIR}"/${P}-build

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default

	strip-linguas -u bfd/po opcodes/po
}

src_configure() {
	strip-unsupported-flags

	myconf+=(
			--disable-dependency-tracking
			--disable-werror
			--disable-{binutils,etc,gas,gold,gprof,ld}
			--enable-64-bit-bfd
			--disable-install-libbfd
			--disable-install-libiberty
			--without-guile
			--disable-readline
			--with-system-readline
			--without-zlib
			--with-system-zlib
			--with-separate-debug-dir="${EPREFIX}"/usr/lib/debug
			$(use_enable server gdbserver auto)
			$(use_with xml expat)
			$(use_with lzma)
			$(use multitarget && echo --enable-targets=all)
			$(use_with python python "${EPYTHON}")
		)

	export ac_cv_path_pkg_config_prog_path="$(tc-getPKG_CONFIG)"

	mkdir "${GDB_BUILD_DIR}" || die
	pushd "${GDB_BUILD_DIR}" || die
		ECONF_SOURCE=${S}
		econf "${myconf[@]}"
	popd
}

src_compile() {
	emake -C "${GDB_BUILD_DIR}"
}

src_test() {
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
	rm -f "${ED}"/usr/share/info/{annotate,bfd,configure,standards}.info*

	if use python; then
		python_optimize "${ED}"/usr/share/gdb/python/gdb
	fi
}

pkg_postinst() {
	# portage doesnt unmerge files in /etc
	rm -vf "${EROOT}"/etc/skel/.gdbinit
}

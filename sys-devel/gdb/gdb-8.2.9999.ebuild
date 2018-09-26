# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit flag-o-matic eutils python-single-r1 git-r3

DESCRIPTION="GNU debugger"
HOMEPAGE="https://sourceware.org/gdb/"
EGIT_REPO_URI="git://sourceware.org/git/binutils-gdb.git"
EGIT_BRANCH="gdb-8.2-branch"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="+client lzma multitarget nls +python +server test vanilla xml"
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
	|| ( client server )
"

RDEPEND="server? ( !dev-util/gdbserver )
	client? (
		>=lib-sys/ncurses-5.2-r2:0=
		lib-sys/readline:0=
		lzma? ( app-compression/xz-utils )
		python? ( ${PYTHON_DEPS} )
		xml? ( lib-dev/expat )
		lib-sys/zlib
	)"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	sys-app/texinfo
	client? (
		sys-devel/bison
		test? ( dev-util/dejagnu )
		nls? ( sys-devel/gettext )
	)"

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
			$(use_enable nls)
			$(use multitarget && echo --enable-targets=all)
			$(use_with python python "${EPYTHON}")
		)
	econf "${myconf[@]}"
}

src_test() {
	nonfatal emake check || ewarn "tests failed"
}

src_install() {
	if use server && ! use client; then
		cd gdb/gdbserver || die
	fi
	default
	if use client; then
		find "${ED}"/usr -name libiberty.a -delete || die
	fi
	cd "${S}" || die

	# Delete translations that conflict with binutils-libs. #528088
	# Note: Should figure out how to store these in an internal gdb dir.
	if use nls ; then
		find "${ED}" \
			-regextype posix-extended -regex '.*/(bfd|opcodes)[.]g?mo$' \
			-delete || die
	fi

	# Remove shared info pages
	rm -f "${ED}"/usr/share/info/{annotate,bfd,configure,standards}.info*
}

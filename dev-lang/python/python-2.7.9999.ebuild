# Distributed under the terms of the GNU General Public License v2

EAPI=7

WANT_LIBTOOL="none"

inherit autotools flag-o-matic toolchain-funcs git-r3

DESCRIPTION="An interpreted, interactive, object-oriented programming language"
HOMEPAGE="https://www.python.org/"
EGIT_REPO_URI="https://github.com/python/cpython.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

LICENSE="PSF-2"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

RDEPEND="app-compression/bzip2:0=
	app-compression/xz-utils:0=
	>=lib-sys/zlib-1.1.3:0=
	lib-dev/libffi
	sys-devel/gettext
	lib-net/libnsl
	lib-sys/ncurses
	lib-sys/readline
	lib-sys/sqlite
	virtual/ssl
	>=lib-dev/expat-2.1:0=
"

src_prepare() {
	# Ensure that internal copies of expat, libffi and zlib are not used.
	rm -r Modules/expat || die
	rm -r Modules/_ctypes/libffi* || die
	rm -r Modules/zlib || die

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-fpectl
		--enable-shared
		$(use_enable ipv6)
		--with-computed-gotos
		--with-system-expat
		--with-system-ffi
		--without-ensurepip
	)
	ECONF_SOURCE=${S} OPT="" econf "${myconf[@]}"
}

src_install() {
	default

	rm "${ED}"/usr/bin/{pydoc,idle,2to3,python,python-config}
	rm -rf "${ED}"/usr/share/man
}

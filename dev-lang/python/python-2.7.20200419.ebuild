# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=8d21aa21f2cbc6d50aab3f420bb23be1d081dac4

inherit autotools flag-o-matic toolchain-funcs

DESCRIPTION="An interpreted, interactive, object-oriented programming language"
HOMEPAGE="https://www.python.org/"
SRC_URI="https://github.com/python/cpython/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/c${PN}-${SNAPSHOT}

LICENSE="PSF-2"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

DEPEND="
	app-compression/bzip2
	app-compression/xz-utils
	lib-core/zlib
	lib-dev/libffi
	sys-devel/gettext
	lib-net/libnsl
	lib-core/ncurses
	lib-core/readline
	lib-core/sqlite
	virtual/ssl
	lib-dev/expat
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

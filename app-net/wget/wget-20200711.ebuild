# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic python-any-r1 toolchain-funcs

DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="https://www.gnu.org/software/wget/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ipv6 nls +openssl pcre static test uuid zlib"

LIB_DEPEND="
	pcre? ( lib-dev/libpcre[static-libs(+)] )
	uuid? ( sys-app/util-linux[static-libs(+)] )
	zlib? ( lib-sys/zlib[static-libs(+)] )
"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="
	${RDEPEND}
	app-compression/xz-utils
	dev-util/pkgconf
	static? ( ${LIB_DEPEND} )
	test? (
		${PYTHON_DEPS}
		dev-lang/perl
		)
	nls? ( sys-devel/gettext )

	openssl? ( virtual/ssl )
"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_configure() {
	local myconf=(
		--disable-assert
		--disable-rpath
		--without-included-libunistring
		--without-libunistring-prefix
		$(usex openssl '--with-openssl=yes' '--with-openssl=no')
		$(usex openssl '--with-ssl=openssl' '--with-ssl=gnutls')
		$(use_enable debug)
		$(use_enable ipv6)
		$(use_enable nls)
		$(use_enable pcre)
		$(use_with uuid libuuid)
		$(use_with zlib)
	)
	ac_cv_libunistring=no econf "${myconf[@]}"
}

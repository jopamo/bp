# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic python-any-r1

DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="https://www.gnu.org/software/wget/"
SRC_URI="mirror://gnu/wget/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ipv6 libpsl nls pcre static test uuid zlib"

LIB_DEPEND="
	pcre? ( lib-dev/libpcre[static-libs(+)] )
	uuid? ( sys-app/util-linux[static-libs(+)] )
	zlib? ( lib-sys/zlib[static-libs(+)] )
"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	dev-util/pkgconf
	static? ( ${LIB_DEPEND} )
	test? (
		${PYTHON_DEPS}
		dev-lang/perl
		)
	libpsl? ( lib-dev/libpsl )
	nls? ( sys-devel/gettext )
	virtual/ssl"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_configure() {
	local myconf=(
		--disable-assert
		--disable-rpath
		--with-ssl=openssl
		--with_libidn2=no
		$(use_enable debug)
		$(use_enable ipv6)
		$(use_enable nls)
		$(use_enable pcre)
		$(use_with uuid libuuid)
		$(use_with zlib)
		$(use_with libpsl)
	)
	econf "${myconf[@]}"
}

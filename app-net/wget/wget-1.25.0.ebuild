# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-any-r1

DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="https://www.gnu.org/software/wget/"
SRC_URI="mirror://gnu/wget/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ipv6 libpsl nls pcre static test uuid zlib"

LIB_DEPEND="
	pcre? ( lib-core/libpcre2[static-libs(+)] )
	uuid? ( app-core/util-linux[static-libs(+)] )
	zlib? ( lib-core/zlib[static-libs(+)] )
"

DEPEND="
	!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	app-compression/xz-utils
	static? ( ${LIB_DEPEND} )
	test? (
		${PYTHON_DEPS}
		app-lang/perl
		)
	libpsl? ( lib-net/libpsl )
	nls? ( app-build/gettext )
	virtual/ssl
"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_configure() {
	local myconf=(
		--disable-assert
		--disable-rpath
		--with-ssl=openssl
		--disable-iri
		--disable-pcre
		$(use_enable debug)
		$(use_enable ipv6)
		$(use_enable nls)
		$(use_enable pcre pcre2)
		$(use_with uuid libuuid)
		$(use_with zlib)
		$(use_with libpsl)
	)
	econf "${myconf[@]}"
}

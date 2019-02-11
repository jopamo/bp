# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit flag-o-matic python-any-r1 toolchain-funcs

DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="https://www.gnu.org/software/wget/"
SRC_URI="mirror://gnu/wget/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug gnutls idn ipv6 libressl nls ntlm pcre +ssl static test uuid zlib"
REQUIRED_USE=" ntlm? ( !gnutls ssl ) gnutls? ( ssl )"

# Force a newer libidn2 to avoid libunistring deps. #612498
LIB_DEPEND="
	idn? ( >=lib-net/libidn2-0.14[static-libs(+)] )
	pcre? ( lib-dev/libpcre[static-libs(+)] )
	ssl? (
		gnutls? ( lib-net/gnutls:0=[static-libs(+)] )
		!gnutls? (
			!libressl? ( lib-dev/openssl:0=[static-libs(+)] )
			libressl? ( lib-dev/libressl[static-libs(+)] )
		)
	)
	uuid? ( sys-app/util-linux[static-libs(+)] )
	zlib? ( lib-sys/zlib[static-libs(+)] )
"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="
	${RDEPEND}
	app-compression/xz-utils
	dev-util/pkgconfig
	static? ( ${LIB_DEPEND} )
	test? (
		${PYTHON_DEPS}
		dev-lang/perl
		)
	nls? ( sys-devel/gettext )
"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_configure() {
	local myeconfargs=(
		--disable-assert
		--disable-rpath
		--without-included-libunistring
		--without-libunistring-prefix
		$(use_enable debug)
		$(use_enable idn iri)
		$(use_enable ipv6)
		$(use_enable nls)
		$(use_enable ntlm)
		$(use_enable pcre)
		$(use_enable ssl digest)
		$(use_enable ssl opie)
		$(use_with idn libidn)
		$(use_with ssl ssl $(usex gnutls gnutls openssl))
		$(use_with uuid libuuid)
		$(use_with zlib)
	)
	ac_cv_libunistring=no econf "${myeconfargs[@]}"
}

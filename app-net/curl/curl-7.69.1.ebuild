# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A command line tool and library for transferring data with URL syntax"
HOMEPAGE="https://curl.haxx.se/"
SRC_URI="https://curl.haxx.se/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="adns ipv6 ldap ssh static-libs test nghttp2"

RDEPEND="ldap? ( app-net/openldap )
		adns? ( lib-net/c-ares:0 )
		ssh? ( lib-net/libssh2[static-libs?] )
		nghttp2? ( lib-net/nghttp2[static-libs?] )
		lib-sys/zlib
"

DEPEND="${RDEPEND}
	dev-util/pkgconf
	lib-net/mbedtls:0
	test? (
		sys-app/diffutils
		dev-lang/perl
	)"

PATCHES=( "${FILESDIR}"/curl-respect-cflags-3.patch )

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable ldap)
		$(use_enable ldap ldaps)
		$(use_with ssh libssh2)
		$(use_with nghttp2)
		$(use_enable adns ares)
		$(use_enable ipv6)
		--without-ssl
		--with-mbedtls
		--with-zlib
		--with-random=/dev/urandom
		--enable-versioned-symbols
		--enable-threaded-resolver
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

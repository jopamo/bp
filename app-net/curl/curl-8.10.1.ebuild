# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A command line tool and library for transferring data with URL syntax"
HOMEPAGE="https://curl.haxx.se/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://github.com/curl/curl.git"
else
	SRC_URI="https://curl.haxx.se/download/${P}.tar.bz2"
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="adns brotli ipv6 ldap libpsl mbedtls ssh ssl static-libs test nghttp2 zlib zstd"

DEPEND="
		lib-core/zlib
		adns? ( lib-net/c-ares )
		brotli? ( app-compression/brotli )
		ldap? ( app-net/openldap )
		libpsl? ( lib-net/libpsl )
		mbedtls? ( lib-net/mbedtls )
		nghttp2? ( lib-net/nghttp2[static-libs?] )
		ssh? ( lib-net/libssh2[static-libs?] )
		test? (
			app-core/diffutils
			app-lang/perl )
		zlib? ( lib-core/zlib )
		zstd? ( app-compression/zstd )
"

PATCHES=( "${FILESDIR}"/curl-respect-cflags-3.patch )

src_prepare() {
	if [[ ${PV} == *9999 ]] ; then
		eautoreconf
	fi

	default
}

src_configure() {
	local myconf=(
		$(use_enable adns ares)
		$(use_enable ipv6)
		$(use_enable ldap ldaps)
		$(use_enable ldap)
		$(use_enable static-libs static)
		$(use_with brotli)
		$(use_with libpsl)
		$(use_with mbedtls)
		$(use_with nghttp2)
		$(use_with ssh libssh2)
		$(use_with ssl)
		$(use_with zlib)
		$(use_with zstd)
		--enable-threaded-resolver
		--enable-versioned-symbols
		--with-zlib
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

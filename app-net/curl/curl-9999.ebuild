# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A command line tool and library for transferring data with URL syntax"
HOMEPAGE="https://curl.haxx.se/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://github.com/curl/curl.git"
else
	SRC_URI="https://curl.haxx.se/download/${P}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="adns ipv6 ldap libpsl mbedtls ssh ssl static-libs test nghttp2 zstd"

DEPEND="
		ldap? ( app-net/openldap )
		libpsl? ( lib-net/libpsl )
		adns? ( lib-net/c-ares )
		ssh? ( lib-net/libssh2[static-libs?] )
		nghttp2? ( lib-net/nghttp2[static-libs?] )
		lib-sys/zlib
		mbedtls? ( lib-net/mbedtls )
		zstd? ( app-compression/zstd )
		test? (
			sys-app/diffutils
			dev-lang/perl )
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
		$(use_enable static-libs static)
		$(use_enable ldap)
		$(use_enable ldap ldaps)
		$(use_with ssh libssh2)
		$(use_with nghttp2)
		$(use_enable adns ares)
		$(use_enable ipv6)
		$(use_with mbedtls)
		$(use_with ssl)
		$(use_with libpsl)
		$(use_with zstd)
		--with-zlib
		--with-random=/dev/urandom
		--enable-versioned-symbols
		--enable-threaded-resolver
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

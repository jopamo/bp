# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic autotools qa-policy

DESCRIPTION="A command line tool and library for transferring data with URL syntax"
HOMEPAGE="https://curl.se/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/curl/curl.git"
else
	SNAPSHOT=4102400028612bf83c61755efbe4cdef49b231b7
	SRC_URI="https://github.com/curl/curl/archive/${SNAPSHOT}.tar.gz -> curl-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/curl-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="+cares ipv6 ldap +nghttp2 +shared ssh +static-libs test"
REQUIRED_USE="
	|| ( shared static-libs )
	ldap? ( shared )
"

QA_CONFIG_IMPL_DECL_SKIP=(
	closesocket
	CloseSocket
	ioctlsocket
	IoctlSocket
)

RDEPEND="
	virtual/ssl[shared?,static-libs?]
	static-libs? ( lib-core/zlib[static-libs(+)] )
	!static-libs? ( lib-core/zlib )
	cares? (
		static-libs? ( lib-net/c-ares[static-libs(+)] )
		!static-libs? ( lib-net/c-ares )
	)
	ldap? ( app-net/openldap )
	nghttp2? (
		static-libs? ( lib-net/nghttp2[static-libs(+)] )
		!static-libs? ( lib-net/nghttp2 )
	)
	ssh? (
		static-libs? ( lib-misc/libssh2[static-libs(+)] )
		!static-libs? ( lib-misc/libssh2 )
	)
"

DEPEND="
	${RDEPEND}
	test? (
		app-core/diffutils
		app-lang/perl
	)
"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf

	filter-flags -Wl,-z,defs
}

src_configure() {
	local myconf=(
		$(use_enable shared shared)
		$(use_enable static-libs static)
		--with-openssl
		--with-zlib
		--without-amissl
		--without-brotli
		--without-gnutls
		--without-libpsl
		--without-libssh
		--without-mbedtls
		--without-rustls
		--without-schannel
		--without-wolfssl
		--without-zstd
		--with-ca-bundle=/etc/ssl/certs/ca-certificates.crt
		--with-ca-path=/etc/ssl/certs
		$(use_enable cares ares)
		$(use_enable ipv6)
		$(use_enable ldap ldaps)
		$(use_enable ldap)
		$(use_with nghttp2)
		$(use_with ssh libssh2)
		$(usex cares --disable-threaded-resolver --enable-threaded-resolver)
		--enable-versioned-symbols
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install

	dodoc scripts/mk-ca-bundle.pl
}

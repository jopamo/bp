# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="A command line tool and library for transferring data with URL syntax"
HOMEPAGE="https://curl.haxx.se/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/curl/curl.git"
else
SNAPSHOT=276a4af4741c7ac5f4e24b22458146ebab049dcd
	SRC_URI="https://github.com/curl/curl/archive/${SNAPSHOT}.tar.gz -> curl-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/curl-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="adns brotli ipv6 ldap libpsl mbedtls ssh ssl static-libs test nghttp2 zlib zstd"

RESTRICT="network-sandbox"

DEPEND="
		lib-core/zlib
		adns? ( lib-net/c-ares )
		brotli? ( app-compression/brotli )
		ldap? ( app-net/openldap )
		libpsl? ( lib-net/libpsl )
		mbedtls? ( lib-net/mbedtls )
		nghttp2? ( lib-net/nghttp2[static-libs?] )
		ssh? ( lib-net/libssh[static-libs?] )
		test? (
			app-core/diffutils
			app-lang/perl )
		zlib? ( lib-core/zlib )
		zstd? ( app-compression/zstd )
"

src_prepare() {
	append-flags -ffat-lto-objects

	default
	eautoreconf

	filter-flags -Wl,-z,defs

	#scripts/mk-ca-bundle.pl -k || die
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
		$(use_with ssh libssh)
		$(use_with ssl)
		$(use_with zlib)
		$(use_with zstd)
		--enable-threaded-resolver
		--enable-versioned-symbols
		--with-zlib
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
    default

    #insinto /etc/ssl/certs/
	#newins ca-bundle.crt cacert.pem
	#dosym -r /etc/ssl/certs/cacert.pem /etc/ssl/certs/ca-bundle.crt
	#dosym -r /etc/ssl/certs/cacert.pem /etc/ssl/certs/ca-certificates.crt

    #cat > "${T}"/99curl <<- EOF || die
	#	SSL_CERT_FILE="/etc/ssl/certs/cacert.pem"
	#	CURL_CA_BUNDLE="/etc/ssl/certs/cacert.pem"
	#	GIT_SSL_CAINFO="/etc/ssl/certs/cacert.pem"
	#	REQUESTS_CA_BUNDLE="/etc/ssl/certs/cacert.pem"
	#EOF

    #doenvd "${T}"/99curl

    dobin scripts/mk-ca-bundle.pl
}

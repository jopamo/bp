# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GNU TLS library providing SSL/TLS and cryptography (TLS 1.3 etc.)"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="https://github.com/gnutls/gnutls/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="mirror://gnupg/gnutls/v$(ver_cut 1-2)/${P}.tar.xz
		https://www.gnupg.org/ftp/gcrypt/gnutls/v$(ver_cut 1-2)/${P}.tar.xz"
S="${WORKDIR}/${PN}-$(ver_cut 1-4)"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="brotli cxx dane seccomp static-libs test tools valgrind zlib zstd"

DEPEND="
	lib-core/nettle[gmp]
	lib-core/gmp
	brotli? ( app-compression/brotli )
	dane? ( lib-net/unbound )
	seccomp? ( lib-core/libseccomp )
	valgrind? ( app-dev/valgrind )
	zlib? ( lib-core/zlib )
	zstd? ( app-compression/zstd )
"

pkg_setup() {
	export TZ=UTC
}

src_configure() {
	local myconf=(
		$(use_enable cxx)
		$(use_enable dane libdane)
		$(use_enable seccomp seccomp-tests)
		$(use_enable static-libs static)
		$(use_enable test tests)
		$(use_enable tools)
		$(use_enable valgrind valgrind-tests)
		$(use_with brotli)
		$(use_with zlib)
		$(use_with zstd)
		--disable-doc
		--disable-full-test-suite
		--disable-gtk-doc
		--disable-heartbeat-support
		--disable-manpages
		--disable-nls
		--enable-openssl-compatibility
		--with-included-libtasn1
		--with-included-unistring
		--without-p11-kit
		--without-tpm
		--with-unbound-root-key-file="${EPREFIX}/etc/dnssec/root-anchors.txt"
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

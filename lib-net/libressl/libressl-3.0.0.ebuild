# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Free version of the SSL/TLS protocol forked from OpenSSL"
HOMEPAGE="https://www.libressl.org/"
SRC_URI="https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${P}.tar.gz"

LICENSE="ISC openssl"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

PDEPEND="app-misc/ca-certificates"

filter-flags -flto\=\* -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	touch crypto/Makefile.in

	sed -i \
		-e '/^[ \t]*CFLAGS=/s#-g ##' \
		-e '/^[ \t]*CFLAGS=/s#-g"#"#' \
		-e '/^[ \t]*CFLAGS=/s#-O2 ##' \
		-e '/^[ \t]*CFLAGS=/s#-O2"#"#' \
		-e '/^[ \t]*USER_CFLAGS=/s#-O2 ##' \
		-e '/^[ \t]*USER_CFLAGS=/s#-O2"#"#' \
		configure || die "fixing CFLAGS failed"

	if ! use test ; then
	sed -i \
		-e '/^[ \t]*SUBDIRS =/s#tests##' \
		Makefile.in || die "Removing tests failed"
	fi

	eapply_user
}

src_configure() {
	ECONF_SOURCE="${S}" econf \
		--enable-asm \
		$(use_enable static-libs static)
}

src_test() {
	emake check
}

src_install() {
	default
	dosym libssl.so usr/lib/libssl.so.1.0.0
	dosym libssl.so usr/lib/libssl.so.1.1
	dosym libcrypto.so usr/lib/libcrypto.so.1.0.0
	dosym libcrypto.so usr/lib/libcrypto.so.1.1

	find ${ED} -xtype l -delete
}

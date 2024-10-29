# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Free version of the SSL/TLS protocol forked from OpenSSL"
HOMEPAGE="https://www.libressl.org/"
SRC_URI="https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${P}.tar.gz
		https://www.mirrorservice.org/pub/OpenBSD/LibreSSL/${P}.tar.gz"

LICENSE="ISC openssl"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_prepare() {
	filter-flags -Wl,-z,defs
	append-ldflags -Wl,-z,noexecstack

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
	local myconf=(
		--enable-asm
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
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

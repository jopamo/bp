# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Client that groks URLs"
HOMEPAGE="https://curl.haxx.se/"
SRC_URI="https://curl.haxx.se/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="ldap adns ssh test ipv6 static-libs mbedtls"

RDEPEND="ldap? ( app-net/openldap )
		adns? ( lib-net/c-ares:0 )
		ssh? ( lib-net/libssh2[static-libs?] )
		lib-sys/zlib
"

DEPEND="${RDEPEND}
	>=dev-util/pkgconf-0-r1
	mbedtls? ( lib-net/mbedtls )
	test? (
		sys-app/diffutils
		dev-lang/perl
	)"

PATCHES=( 	${FILESDIR}/828392ae10e6e7855e66a78c01346f9cd1127467.patch
			${FILESDIR}/curl-respect-cflags-3.patch
)

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_with mbedtls mbedtls)
		$(use_enable ldap)
		$(use_enable ldap ldaps)
		$(use_with ssh libssh2)
		$(use_enable adns ares)
		$(use_enable ipv6)
		--with-zlib
		--without-ca-bundle
		--without-nss
		--enable-threaded-resolver
		--with-random=/dev/urandom
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

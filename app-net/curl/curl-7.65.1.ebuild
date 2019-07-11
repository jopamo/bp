# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Client that groks URLs"
HOMEPAGE="https://curl.haxx.se/"
SRC_URI="https://curl.haxx.se/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="ldap adns ssh test ipv6 static-libs embed"

RDEPEND="ldap? ( app-net/openldap )
		adns? ( lib-net/c-ares:0 )
		ssh? ( lib-net/libssh2[static-libs?] )
		lib-sys/zlib
"

DEPEND="${RDEPEND}
	>=dev-util/pkgconf-0-r1
	embed? ( lib-net/mbedtls )
	test? (
		sys-app/diffutils
		dev-lang/perl
	)"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_with embed mbedtls)
		--without-ca-bundle
		--without-nss
		--enable-threaded-resolver
		$(use_enable ldap)
		$(use_enable ldap ldaps)
		$(use_with ssh libssh2)
		$(use_enable adns ares)
		$(use_enable ipv6)
		--with-zlib
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm -rf "${ED}"/etc/
}

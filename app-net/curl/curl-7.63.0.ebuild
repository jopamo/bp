# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools

DESCRIPTION="A Client that groks URLs"
HOMEPAGE="https://curl.haxx.se/"
SRC_URI="https://curl.haxx.se/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="ldap ssl adns ssh test ipv6 static-libs"

RDEPEND="ldap? ( net-nds/openldap )
		adns? ( lib-net/c-ares:0 )
		ssh? ( lib-net/libssh2[static-libs?] )
		lib-sys/zlib
"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0-r1
	lib-net/mbedtls
	test? (
		sys-app/diffutils
		dev-lang/perl
	)"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		--with-mbedtls
		--without-ca-bundle
		$(use_enable ldap)
		$(use_enable ldap ldaps)
		$(use_with ssh libssh2)
		$(use_enable adns ares)
		$(use_enable ipv6)
		--with-zlib
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	find "${ED}" -name "*.la" -delete || die
	rm -rf "${ED}"/etc/
}

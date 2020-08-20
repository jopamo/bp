# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson user systemd flag-o-matic

DESCRIPTION="Lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/lighttpd/lighttpd1.4.git"
	inherit git-r3
else
	SRC_URI="https://download.lighttpd.net/lighttpd/releases-1.4.x/${P}.tar.xz"
fi

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 dbi fam gdbm geoip krb5 ldap libev libunwind lua memcached mbedtls mysql
	ssl pcre php test postgres systemd webdav xattr zlib static"

DEPEND="app-compression/lbzip2
	gdbm?     ( lib-sys/gdbm )
	ldap?     ( >=app-net/openldap-2.1.26 )
	libev?    ( >=lib-dev/libev-4.01 )
	mysql?    ( >=virtual/mysql-4.0 )
	php?      ( dev-lang/php:*[cgi] )
	ssl? ( lib-net/libressl )
	xattr? ( sys-app/attr )
	>=lib-dev/libpcre-3.1
	>=lib-sys/zlib-1.1"

BDEPEND="dev-util/pkgconf"

filter-flags -Wl,-z,defs

pkg_setup() {
	enewgroup lighttpd
	enewuser lighttpd -1 -1 /var/lighttpd lighttpd
}

src_configure() {
	local emesonargs=(
		$(meson_use bzip2 with_bzip)
		$(meson_use dbi with_dbi)
		$(meson_use fam with_fam)
		$(meson_use gdbm with_gdbm)
		$(meson_use krb5 with_krb5)
		$(meson_use ldap with_ldap)
		$(meson_use libev with_libev)
		$(meson_use libev with_libev)
		$(meson_use libunwind with_libunwind)
		$(meson_use lua with_lua)
		$(meson_use mbedtls with_mbedtls)
		$(meson_use memcached with_memcached)
		$(meson_use mysql with_mysql)
		$(meson_use pcre with_pcre)
		$(meson_use postgres with_pgsql)
		$(meson_use ssl with_openssl)
		$(meson_use static build_static)
		$(meson_use webdav with_webdav_locks)
		$(meson_use webdav with_webdav_props)
		$(meson_use xattr with_xattr)
		$(meson_use zlib with_zlib)
		-Dmoduledir="${EPREFIX}"/usr/lib
	)
		meson_src_configure
}

src_install() {
	meson_src_install
	mkdir -p "${ED}"/etc/lighttpd
	cp -r "${FILESDIR}"/lighttpd/* "${ED}"/etc/lighttpd/

	keepdir /var/l{ib,og}/lighttpd
	fowners lighttpd:lighttpd /var/l{ib,og}/lighttpd
	fperms 0750 /var/l{ib,og}/lighttpd

	use systemd && systemd_dounit "${FILESDIR}/${PN}.service"
	use systemd && systemd_dotmpfilesd "${FILESDIR}/${PN}.tmpfiles.conf"
}

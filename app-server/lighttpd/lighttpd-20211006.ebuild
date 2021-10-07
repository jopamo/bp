# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson user flag-o-matic

DESCRIPTION="Lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/lighttpd/lighttpd1.4.git"
	inherit git-r3
else
	SNAPSHOT=07c8a6f056bcd8c310a2eb4f83964b2d22c6c141
	SRC_URI="https://github.com/lighttpd/lighttpd1.4/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}1.4-${SNAPSHOT}
fi

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 dbi fam gdbm geoip krb5 ldap libev libunwind lua memcached
	mbedtls mysql ssl pcre php test tmpfilesd postgres systemd webdav
	xattr zlib static"

DEPEND="
	app-compression/bzip2
	lib-core/zlib
	lib-core/libpcre
	gdbm?     ( lib-core/gdbm )
	ldap?     ( app-net/openldap )
	libev?    ( lib-dev/libev )
	libunwind? ( lib-live/libunwind )
	mbedtls?  ( lib-net/mbedtls )
	mysql?    ( app-server/mariadb )
	php?      ( dev-lang/php:*[cgi] )
	ssl? ( virtual/ssl )
	xattr? ( app-core/attr )
"

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

	mkdir -p "${ED}"/var/log/lighttpd
	touch "${ED}"/var/log/lighttpd/access.log
	touch "${ED}"/var/log/lighttpd/error.log

	fowners -R lighttpd:lighttpd /var/log/lighttpd
	fperms -R 0750 /var/log/lighttpd

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		doins "${FILESDIR}/${PN}.tmpfiles.conf"
	fi

	insinto /etc/lighttpd
	doins doc/config/conf.d/mime.conf
	doins "${FILESDIR}"/lighttpd.conf
	doins "${FILESDIR}"/lighttpd_example.conf
}

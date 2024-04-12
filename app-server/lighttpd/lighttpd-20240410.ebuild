# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson user flag-o-matic

DESCRIPTION="Lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/lighttpd/lighttpd1.4.git"
	inherit git-r3
else
	SNAPSHOT=081d6cb0e778b795ff2355fe0ede15d47f28ea7e
	SRC_URI="https://github.com/lighttpd/lighttpd1.4/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}1.4-${SNAPSHOT}
fi

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 dbi fam geoip krb5 ldap libev libunwind lua
	mbedtls mysql ssl php test tmpfilesd postgres systemd webdav
	xattr zlib static"

DEPEND="
	lib-core/zlib
	lib-core/libpcre2
	bzip2? ( app-compression/bzip2 )
	ldap?     ( app-net/openldap )
	libev?    ( lib-dev/libev )
	libunwind? ( lib-live/libunwind )
	mbedtls?  ( lib-net/mbedtls )
	mysql?    ( app-server/mariadb )
	php?      ( app-lang/php )
	ssl? ( virtual/ssl )
	xattr? ( app-core/attr )
"
BDEPEND="app-dev/pkgconf"

pkg_setup() {
	enewgroup lighttpd
	enewuser lighttpd -1 -1 /var/lighttpd lighttpd
}

src_configure() {
	filter-flags -Wl,-z,defs

	local emesonargs=(
		$(meson_feature bzip2 with_bzip)
		$(meson_feature dbi with_dbi)
		$(meson_feature fam with_fam)
		$(meson_feature krb5 with_krb5)
		$(meson_feature ldap with_ldap)
		$(meson_feature libev with_libev)
		$(meson_feature libunwind with_libunwind)
		$(meson_use lua with_lua)
		$(meson_use mbedtls with_mbedtls)
		$(meson_feature mysql with_mysql)
		$(meson_feature postgres with_pgsql)
		$(meson_use ssl with_openssl)
		$(meson_use static build_static)
		$(meson_feature webdav with_webdav_locks)
		$(meson_feature webdav with_webdav_props)
		$(meson_use xattr with_xattr)
		$(meson_feature zlib with_zlib)
		-Dmoduledir="${EPREFIX}"/usr/lib
		-Dwith_pcre=pcre2
		-Dwith_pcre2=true
	)
		meson_src_configure
}

src_install() {
	meson_src_install

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

pkg_postinst() {
	if [ ! -d "${EROOT}"/var/log/lighttpd ] ; then
		mkdir -p "${EROOT}"/var/log/lighttpd
		touch "${EROOT}"/var/log/lighttpd/{access,error}.log
		chown -R lighttpd:lighttpd "${EROOT}"/var/log/lighttpd
		chmod -R 0750 "${EROOT}"/var/log/lighttpd
	fi
}

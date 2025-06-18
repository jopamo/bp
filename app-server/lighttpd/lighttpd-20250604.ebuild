# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson user flag-o-matic

DESCRIPTION="Lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/lighttpd/lighttpd1.4.git"
	inherit git-r3
else
SNAPSHOT=8834056651265610993ace287b39deabba7b3207
	SRC_URI="https://github.com/lighttpd/lighttpd1.4/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/lighttpd1.4-${SNAPSHOT}
fi

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 dbi fam geoip krb5 ldap libunwind lua mbedtls mysql php
postgres ssl static systemd test tmpfilesd webdav xattr xxhash zlib
zstd"

DEPEND="

	lib-core/libpcre2
	zlib? ( lib-core/zlib )
	xxhash? ( lib-misc/xxhash )
	bzip2? ( app-compression/bzip2 )
	zstd? ( app-compression/zstd )
	ldap?     ( app-net/openldap )
	libunwind? ( lib-util/libunwind )
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
		$(meson_feature xxhash with_xxhash)
		$(meson_feature zstd with_zstd)
		-Dmoduledir="${EPREFIX}"/usr/lib
		-Dwith_pcre2=true
	)
		meson_src_configure
}

src_install() {
	meson_src_install

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/lighttpd.service"
	fi

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		doins "${FILESDIR}/lighttpd.tmpfiles.conf"
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

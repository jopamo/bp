# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 autotools

DESCRIPTION="The PHP language runtime engine"
HOMEPAGE="https://secure.php.net/"
EGIT_REPO_URI="https://github.com/php/php-src.git"
EGIT_BRANCH="PHP-$(ver_cut 1).$(ver_cut 2)"

LICENSE="PHP-3.01 BSD-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+fpm"

DEPEND="
	app-compression/bzip2
	app-compression/xz-utils
	app-net/curl
	app-server/opensmtpd
	dev-util/re2c
	lib-core/gmp
	lib-core/libedit
	lib-core/libpcre
	lib-dev/oniguruma
	lib-core/gdbm
	app-core/acl
	sys-devel/bison
	sys-devel/gettext
	virtual/ssl
"

filter-flags -Wl,-z,defs -flto\=\*

src_prepare() {
	default

	# Emulate buildconf to support cross-compilation
	rm -fr aclocal.m4 autom4te.cache config.cache \
		configure main/php_config.h.in || die
	eautoconf --force
	eautoheader
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--localstatedir="${EPREFIX}"/var
		--prefix="${EPREFIX}"/usr
		--sysconfdir="${EPREFIX}"/etc/php
		--with-config-file-path="${EPREFIX}"/etc/php
		--with-config-file-scan-dir="${EPREFIX}"/etc/php/conf.d
		--datadir="${EPREFIX}"/usr/share/php
		--disable-rpath
		--config-cache
		--with-layout=GNU
		--with-zlib
		--enable-calendar
		--enable-dba=shared
		--with-curl
		--without-pear
		--with-openssl
		--enable-bcmath
		--with-bz2
		--with-gdbm
		--with-gmp
		--disable-ftp
		--with-gettext
		--enable-mbstring
		--with-libedit
		--without-readline
		$(use_enable fpm)
		$(usex fpm "--with-fpm-user=lighttpd" "")
		$(usex fpm "--with-fpm-group=lighttpd" "")
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	keepdir /var/{log,run}
	rm -rf "${ED}"/var/run
}

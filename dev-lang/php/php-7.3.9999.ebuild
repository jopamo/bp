# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic systemd git-r3 autotools

DESCRIPTION="The PHP language runtime engine"
HOMEPAGE="https://secure.php.net/"
EGIT_REPO_URI="https://github.com/php/php-src.git"
EGIT_BRANCH="PHP-$(ver_cut 1).$(ver_cut 2)"

LICENSE="PHP-3.01 BSD-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libpcre
	app-net/curl
	sys-app/acl
	virtual/ssl
	app-compression/lbzip2
	lib-sys/gdbm
	lib-dev/gmp
	sys-devel/gettext
	app-compression/xz-utils
	>=sys-devel/bison-3.0.1
	app-server/opensmtpd"

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf	\
		--datadir="${EPREFIX}"/usr/share/php	\
		--enable-fpm	\
		--with-fpm-user=lighttpd	\
		--with-fpm-group=lighttpd	\
		--with-config-file-path="${EPREFIX}"/etc	\
		--with-zlib	\
		--enable-calendar \
		--enable-dba=shared \
		--with-curl	\
		--without-pear	\
		--with-openssl	\
		--enable-bcmath	\
		--with-bz2	\
		--with-gdbm	\
		--with-gmp	\
		--disable-ftp	\
		--with-gettext	\
		--enable-mbstring	\
		--with-libedit	\
		--without-readline
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	default
	keepdir /var/{log,run}
	rm -rf "${ED}"/var/run
}

# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic versionator systemd git-r3 autotools

DESCRIPTION="The PHP language runtime engine"
HOMEPAGE="https://secure.php.net/"
EGIT_REPO_URI="https://github.com/php/php-src.git"
EGIT_BRANCH="PHP-7.3"

LICENSE="PHP-3.01
	BSD
	Zend-2.0
	bcmath? ( LGPL-2.1+ )
	fpm? ( BSD-2 )
	gd? ( gd )
	unicode? ( BSD-2 LGPL-2.1 )"

SLOT=0
KEYWORDS="amd64 arm64"

# We can build the following SAPIs in the given order
SAPIS="embed cli cgi fpm phpdbg"

# SAPIs and SAPI-specific USE flags (cli SAPI is default on):
IUSE="${IUSE}
	${SAPIS/cli/+cli}
	threads"

IUSE="${IUSE} acl argon2 bcmath bzip2 calendar cdb cjk
	coverage +ctype curl debug
	enchant exif +fileinfo +filter firebird
	flatfile ftp gd gdbm gmp +hash +iconv imap inifile
	intl iodbc ipv6 +json ldap ldap-sasl libedit
	mhash mssql mysql mysqli nls
	oci8-instant-client odbc +opcache pcntl pdo +phar +posix postgres qdbm
	readline recode +session session-mm sharedmem
	+simplexml snmp soap sockets spell sqlite ssl
	sysvipc systemd test tidy +tokenizer tokyocabinet truetype unicode wddx webp
	+xml xmlreader xmlwriter xmlrpc xpm xslt zip zip-encryption zlib"

# The supported (that is, autodetected) versions of BDB are listed in
# the ./configure script. Other versions *work*, but we need to stick to
# the ones that can be detected to avoid a repeat of bug #564824.
COMMON_DEPEND="
	>=lib-dev/libpcre-8.32[unicode]
	acl? ( sys-app/acl )
	argon2? ( app-crypt/argon2:= )
	bzip2? ( app-compression/lbzip2:0= )
	cdb? ( || ( dev-db/cdb dev-db/tinycdb ) )
	coverage? ( dev-util/lcov )
	curl? ( >=app-net/curl-7.10.5 )
	enchant? ( app-text/enchant )
	firebird? ( dev-db/firebird )
	gd? ( lib-media/libjpeg-turbo:0 lib-media/libpng:0= lib-sys/zlib )
	gdbm? ( >=lib-sys/gdbm-1.8.0:0= )
	gmp? ( lib-dev/gmp:0= )
	intl? ( lib-dev/icu:= )
	iodbc? ( dev-db/libiodbc )
	ldap? ( >=net-nds/openldap-1.2.11 )
	ldap-sasl? ( lib-dev/cyrus-sasl >=net-nds/openldap-1.2.11 )
	libedit? ( || ( sys-freebsd/freebsd-lib lib-dev/libedit ) )
	mssql? ( dev-db/freetds[mssql] )
	nls? ( sys-devel/gettext )
	oci8-instant-client? ( dev-db/oracle-instantclient-basic )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	postgres? ( dev-db/postgresql:* )
	qdbm? ( dev-db/qdbm )
	readline? ( lib-sys/readline:0= )
	recode? ( app-text/recode )
	session-mm? ( lib-dev/mm )
	simplexml? ( >=lib-dev/libxml2-2.6.8 )
	snmp? ( >=app-net/net-snmp-5.2 )
	soap? ( >=lib-dev/libxml2-2.6.8 )
	spell? ( >=app-text/aspell-0.50 )
	sqlite? ( >=lib-sys/sqlite-3.7.6.3 )
	ssl? ( lib-dev/openssl:0= )
	tidy? ( || ( app-text/tidy-html5 app-text/htmltidy ) )
	tokyocabinet? ( dev-db/tokyocabinet )
	truetype? ( lib-media/freetype )
	unicode? ( lib-dev/oniguruma:= )
	wddx? ( >=lib-dev/libxml2-2.6.8 )
	webp? ( lib-media/libwebp:0= )
	xml? ( >=lib-dev/libxml2-2.6.8 )
	xmlrpc? ( >=lib-dev/libxml2-2.6.8 )
	xmlreader? ( >=lib-dev/libxml2-2.6.8 )
	xmlwriter? ( >=lib-dev/libxml2-2.6.8 )
	xpm? ( x11-libs/libXpm )
	xslt? ( lib-dev/libxslt >=lib-dev/libxml2-2.6.8 )
	zip? ( lib-sys/zlib:0= )
	zip-encryption? ( >=lib-dev/libzip-1.2.0:= )
	zlib? ( lib-sys/zlib:0= )
"

RDEPEND="${COMMON_DEPEND}
	app-server/opensmtpd
	fpm? ( systemd? ( sys-app/systemd ) )"

# Bison isn't actually needed when building from a release tarball
# However, the configure script will warn if it's absent or if you
# have an incompatible version installed. See bug 593278.
DEPEND="${COMMON_DEPEND}
	app-compression/xz-utils
	>=sys-devel/bison-3.0.1"

# Without USE=readline or libedit, the interactive "php -a" CLI will hang.
REQUIRED_USE="
	|| ( cli cgi fpm embed phpdbg )
	cli? ( ^^ ( readline libedit ) )
	truetype? ( gd )
	webp? ( gd )
	cjk? ( gd )
	exif? ( gd )
	xpm? ( gd )
	gd? ( zlib )
	simplexml? ( xml )
	soap? ( xml )
	wddx? ( xml )
	xmlrpc? ( || ( xml iconv ) )
	xmlreader? ( xml )
	xslt? ( xml )
	ldap-sasl? ( ldap )
	mhash? ( hash )
	phar? ( hash )
	qdbm? ( !gdbm )
	readline? ( !libedit )
	recode? ( !imap !mysqli !mysql )
	session-mm? ( session !threads )
	mysql? ( || ( mysqli pdo ) )
	zip-encryption? ( zip )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf	\
		--bindir="${EPREFIX}"/usr/bin	\
		--sbindir="${EPREFIX}"/usr/sbin	\
		--libdir="${EPREFIX}"/usr/lib64	\
		--libexecdir="${EPREFIX}"/usr/libexec	\
		--sysconfdir="${EPREFIX}"/etc	\
		--localstatedir="${EPREFIX}"/var	\
		--datadir="${EPREFIX}"/usr/share/php	\
		--enable-fpm	\
		--with-fpm-user=lighttpd	\
		--with-fpm-group=lighttpd	\
		--with-config-file-path="${EPREFIX}"/etc	\
		--with-zlib	\
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
		--with-readline
}


src_install() {
	emake INSTALL_ROOT="${D}" install
	keepdir /var/{log,run}
	rm -rf "${ED}"/var/run
}


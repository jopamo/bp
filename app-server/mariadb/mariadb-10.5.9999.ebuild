# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs user cmake git-r3

HOMEPAGE="https://mariadb.org/"
DESCRIPTION="An enhanced, drop-in replacement for MySQL"
EGIT_REPO_URI="https://github.com/MariaDB/server.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug kerberos numa profiling static systemd sysusersd tmpfilesd test"

DEPEND="
	lib-core/libxml2
	lib-core/libpcre
	sys-devel/bison
	static? ( virtual/curses[static-libs] )
"

BDEPEND="
	lib-dev/libaio
	lib-dev/jemalloc
	lib-core/zlib
	virtual/ssl
	systemd? ( app-core/systemd )
"

filter-flags -Wl,-z,defs -flto\=\*
append-cxxflags -felide-constructors
append-flags -fno-strict-aliasing

pkg_setup() {
	enewgroup mysql 60 || die "problem adding 'mysql' group"
	enewuser mysql 60 -1 /dev/null mysql || die "problem adding 'mysql' user"
}

src_configure(){
	CMAKE_BUILD_TYPE="Release"

	mycmakeargs=(
		-DCMAKE_C_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
		-DCMAKE_CXX_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DMYSQL_DATADIR="${EPREFIX}/var/lib/mysql"
		-DSYSCONFDIR="${EPREFIX}/etc/mysql"
		-DINSTALL_BINDIR=bin
		-DINSTALL_DOCDIR=share/doc/${PF}
		-DINSTALL_DOCREADMEDIR=share/doc/${PF}
		-DINSTALL_INCLUDEDIR=include/mysql
		-DINSTALL_INFODIR=share/info
		-DINSTALL_LIBDIR=lib
		-DINSTALL_MANDIR=share/man
		-DINSTALL_MYSQLSHAREDIR=share/mariadb
		-DINSTALL_PLUGINDIR=lib/mariadb/plugin
		-DINSTALL_SCRIPTDIR=bin
		-DINSTALL_MYSQLDATADIR="${EPREFIX}/var/lib/mysql"
		-DINSTALL_SBINDIR=sbin
		-DINSTALL_SUPPORTFILESDIR="${EPREFIX}/usr/share/mariadb"
		-DWITH_UNIT_TESTS=$(usex test ON OFF)
		-DWITH_LIBEDIT=0
		-DWITH_ZLIB=system
		-DWITH_PCRE=system
		-DWITHOUT_LIBWRAP=1
		-DENABLED_LOCAL_INFILE=1
		-DMYSQL_UNIX_ADDR="${EPREFIX}/run/mysqld/mysqld.sock"
		-DINSTALL_UNIX_ADDRDIR="${EPREFIX}/run/mysqld/mysqld.sock"
		-DWITH_DEFAULT_COMPILER_OPTIONS=1
		-DWITH_DEFAULT_FEATURE_SET=1
		-DPLUGIN_AUTH_GSSAPI=$(usex kerberos DYNAMIC NO)
		-DAUTH_GSSAPI_PLUGIN_TYPE=$(usex kerberos DYNAMIC OFF)
		-DCONC_WITH_EXTERNAL_ZLIB=YES
		-DWITH_EXTERNAL_ZLIB=YES
		-DSUFFIX_INSTALL_DIR=""
		-DWITH_UNITTEST=OFF
		-DWITHOUT_CLIENTLIBS=YES
		-DCLIENT_PLUGIN_DIALOG=OFF
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=OFF
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DBUILD_CONFIG=mysql_release
		-DWITH_SSL=system
		-DWITH_READLINE=YES
		-DWITH_JEMALLOC=system
		-DPLUGIN_CASSANDRA=NO
		-DCONNECT_WITH_MYSQL=1
		-DCONNECT_WITH_MONGO=OFF
		-DWITH_INNODB_LZO=OFF
		-DINSTALL_SQLBENCHDIR=""
		-DWITH_SYSTEMD=$(usex systemd yes no)
		-DINSTALL_SYSTEMD_UNITDIR=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		-DINSTALL_SYSTEMD_SYSUSERSDIR=$(usex sysusersd "${EPREFIX}/usr/lib/sysusers.d" "false")
		-DINSTALL_SYSTEMD_TMPFILESDIR=$(usex tmpfilesd "${EPREFIX}/usr/lib/tmpfiles.d" "false")
		-DWITH_NUMA=$(usex numa ON OFF)
		-DDEFAULT_CHARSET=utf8
		-DDEFAULT_COLLATION=utf8_general_ci
		-DEXTRA_CHARSETS=all
		-DMYSQL_USER=mysql
		-DDISABLE_SHARED=$(usex static YES NO)
		-DWITH_DEBUG=$(usex debug)
		-DWITH_EMBEDDED_SERVER=OFF
		-DWITH_PROFILING=$(usex profiling)
		-DAWS_SDK_EXTERNAL_PROJECT=OFF
		-DWITH_SAFEMALLOC=OFF
		)

		if use test ; then
			# This is needed for the new client lib which tests a real, open server
			mycmakeargs+=( -DSKIP_TESTS=ON )
		fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	mkdir -p "${ED}"/var/lib/mysql
	fowners -R plex:plex /var/lib/mysql
}

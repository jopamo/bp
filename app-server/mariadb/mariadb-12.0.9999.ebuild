# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs cmake git-r3

DESCRIPTION="An enhanced, drop-in replacement for MySQL"
HOMEPAGE="https://mariadb.org/"
EGIT_REPO_URI="https://github.com/MariaDB/server.git"
EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug kerberos numa profiling static systemd test"

DEPEND="
	lib-core/libxml2
	lib-core/libpcre
	app-build/bison
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

src_configure(){
	CMAKE_BUILD_TYPE="Release"

	mycmakeargs=(
		-DAUTH_GSSAPI_PLUGIN_TYPE=$(usex kerberos DYNAMIC OFF)
		-DAWS_SDK_EXTERNAL_PROJECT=OFF
		-DBUILD_CONFIG=mysql_release
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=OFF
		-DCLIENT_PLUGIN_DIALOG=OFF
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCMAKE_CXX_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
		-DCMAKE_C_FLAGS_RELWITHDEBINFO="$(usex debug '' '-DNDEBUG')"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DCONC_WITH_EXTERNAL_ZLIB=YES
		-DCONNECT_WITH_MONGO=OFF
		-DCONNECT_WITH_MYSQL=1
		-DDEFAULT_CHARSET=utf8
		-DDEFAULT_COLLATION=utf8_general_ci
		-DDISABLE_SHARED=$(usex static YES NO)
		-DENABLED_LOCAL_INFILE=1
		-DEXTRA_CHARSETS=all
		-DINSTALL_BINDIR=bin
		-DINSTALL_DOCDIR=share/doc/${PF}
		-DINSTALL_DOCREADMEDIR=share/doc/${PF}
		-DINSTALL_INCLUDEDIR=include/mysql
		-DINSTALL_INFODIR=share/info
		-DINSTALL_LIBDIR=lib
		-DINSTALL_MANDIR=share/man
		-DINSTALL_MYSQLDATADIR="${EPREFIX}/var/lib/mysql"
		-DINSTALL_MYSQLSHAREDIR=share/mariadb
		-DINSTALL_PLUGINDIR=lib/mariadb/plugin
		-DINSTALL_SBINDIR=sbin
		-DINSTALL_SCRIPTDIR=bin
		-DINSTALL_SQLBENCHDIR=""
		-DINSTALL_SUPPORTFILESDIR="${EPREFIX}/usr/share/mariadb"
		-DINSTALL_SYSTEMD_SYSUSERSDIR="${EPREFIX}/usr/lib/sysusers.d"
		-DINSTALL_SYSTEMD_TMPFILESDIR="${EPREFIX}/usr/lib/tmpfiles.d"
		-DINSTALL_SYSTEMD_UNITDIR=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		-DINSTALL_UNIX_ADDRDIR="${EPREFIX}/run/mysqld/mysqld.sock"
		-DMYSQL_DATADIR="${EPREFIX}/var/lib/mysql"
		-DMYSQL_UNIX_ADDR="${EPREFIX}/run/mysqld/mysqld.sock"
		-DMYSQL_USER=mysql
		-DPLUGIN_AUTH_GSSAPI=$(usex kerberos DYNAMIC NO)
		-DPLUGIN_CASSANDRA=NO
		-DSUFFIX_INSTALL_DIR=""
		-DSYSCONFDIR="${EPREFIX}/etc/mysql"
		-DWITHOUT_CLIENTLIBS=YES
		-DWITHOUT_LIBWRAP=1
		-DWITH_DEBUG=$(usex debug)
		-DWITH_DEFAULT_COMPILER_OPTIONS=1
		-DWITH_DEFAULT_FEATURE_SET=1
		-DWITH_EMBEDDED_SERVER=OFF
		-DWITH_EXTERNAL_ZLIB=YES
		-DWITH_INNODB_LZO=OFF
		-DWITH_JEMALLOC=system
		-DWITH_LIBEDIT=0
		-DWITH_NUMA=$(usex numa ON OFF)
		-DWITH_PCRE=system
		-DWITH_PROFILING=$(usex profiling)
		-DWITH_READLINE=YES
		-DWITH_SAFEMALLOC=OFF
		-DWITH_SSL=system
		-DWITH_SYSTEMD=$(usex systemd yes no)
		-DWITH_UNITTEST=OFF
		-DWITH_UNIT_TESTS=$(usex test ON OFF)
		-DWITH_ZLIB=system
		)

		if use test ; then
			# This is needed for the new client lib which tests a real, open server
			mycmakeargs+=( -DSKIP_TESTS=ON )
		fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	keepdir /var/lib/mysql
	fowners -R mysql:mysql /var/lib/mysql

	ewarn "Install the Database"
	ewarn "mysql_install_db --user=mysql --ldata=/var/lib/mysql"
	ewarn "mysqladmin -u root -h localhost password 'new-password'"
}

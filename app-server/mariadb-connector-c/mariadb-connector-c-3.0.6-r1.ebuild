# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ "${PV}" == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MariaDB/mariadb-connector-c.git"
else
	MY_PN=${PN#mariadb-}
	MY_PV=${PV/_b/-b}
	SRC_URI="https://downloads.mariadb.org/f/${MY_PN}-${PV%_beta}/${PN}-${MY_PV}-src.tar.gz?serve -> ${P}-src.tar.gz"
	S="${WORKDIR%/}/${PN}-${MY_PV}-src"
	KEYWORDS="amd64 arm64"
fi

inherit cmake-utils toolchain-funcs

DESCRIPTION="C client library for MariaDB/MySQL"
HOMEPAGE="https://mariadb.org/"
LICENSE="LGPL-2.1"

SLOT="0/3"
IUSE="+curl gnutls kerberos libressl mysqlcompat +ssl static-libs test"

DEPEND="lib-sys/zlib:=
	curl? ( app-net/curl:0= )
	ssl? (
		gnutls? ( >=lib-net/gnutls-3.3.24:0= )
		!gnutls? (
			libressl? ( lib-dev/libressl:0= )
			!libressl? ( lib-dev/openssl:0= )
		)
	)
	"
RDEPEND="${DEPEND}
	mysqlcompat? (
	!dev-db/mysql[client-libs(+)]
	!dev-db/mysql-cluster[client-libs(+)]
	!app-server/mariadb[client-libs(+)]
	!app-server/mariadb-galera[client-libs(+)]
	!dev-db/percona-server[client-libs(+)]
	!dev-db/mysql-connector-c )
	!>=app-server/mariadb-10.2.0[client-libs(+)]
	"

src_configure() {
	# bug 508724 mariadb cannot use ld.gold
	tc-ld-disable-gold
}

src_configure() {
	local mycmakeargs=(
		-DWITH_EXTERNAL_ZLIB=ON
		-DWITH_SSL:STRING=$(usex ssl $(usex gnutls GNUTLS OPENSSL) OFF)
		-DWITH_CURL=$(usex curl ON OFF)
		-DMARIADB_UNIX_ADDR="${EPREFIX%/}/run/mysqld/mysqld.sock"
		-DINSTALL_LIBDIR="$(get_libdir)"
		-DINSTALL_PLUGINDIR="$(get_libdir)/mariadb/plugin"
		-DINSTALL_BINDIR=bin
		-DWITH_UNIT_TESTS=$(usex test ON OFF)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	if use mysqlcompat ; then
		dosym libmariadb.so.3 /usr/$(get_libdir)/libmysqlclient.so.19
		dosym libmariadb.so.3 /usr/$(get_libdir)/libmysqlclient.so
	fi
}

src_install_all() {
	if ! use static-libs ; then
		find "${D}" -name "*.a" -delete || die
	fi
	if use mysqlcompat ; then
		dosym mariadb_config /usr/bin/mysql_config
		dosym mariadb /usr/include/mysql
	fi
}

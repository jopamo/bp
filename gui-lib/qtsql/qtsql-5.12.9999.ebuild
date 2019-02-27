# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
inherit qt5-build

DESCRIPTION="SQL abstraction library for the Qt5 framework"
KEYWORDS="amd64 arm64"

IUSE="freetds mysql oci8 odbc postgres +sqlite"

REQUIRED_USE="
	|| ( freetds mysql oci8 odbc postgres sqlite )
"

DEPEND="
	~gui-lib/qtcore-${PV}
	freetds? ( dev-db/freetds )
	mysql? ( app-server/mariadb:= )
	oci8? ( dev-db/oracle-instantclient-basic )
	odbc? ( || ( dev-db/unixODBC dev-db/libiodbc ) )
	postgres? ( dev-db/postgresql:* )
	sqlite? ( >=lib-sys/sqlite-3.8.10.2:3 )
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/sql
	src/plugins/sqldrivers
)

QT5_GENTOO_PRIVATE_CONFIG=(
	:sql
)

src_configure() {
	local myconf=(
		$(qt_use freetds  sql-tds    plugin)
		$(qt_use mysql    sql-mysql  plugin)
		$(qt_use oci8     sql-oci    plugin)
		$(qt_use odbc     sql-odbc   plugin)
		$(qt_use postgres sql-psql   plugin)
		$(qt_use sqlite   sql-sqlite plugin)
	)

	use mysql && myconf+=("-I${EPREFIX}/usr/include/mysql" "-L${EPREFIX}/usr/lib64/mysql")
	use oci8 && myconf+=("-I${ORACLE_HOME}/include" "-L${ORACLE_HOME}/lib64")
	use odbc && myconf+=("-I${EPREFIX}/usr/include/iodbc")
	use postgres && myconf+=("-I${EPREFIX}/usr/include/postgresql/pgsql")

	qt5-build_src_configure
}

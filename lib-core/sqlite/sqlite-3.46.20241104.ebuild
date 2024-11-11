# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="A SQL Database Engine in a C Library"
HOMEPAGE="https://sqlite.org/"

SNAPSHOT=d770c86b824ad64013faeb2a0e98ad47c248d143
SRC_URI="https://github.com/sqlite/sqlite/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs debug +tempstore +fts5 +rtree +geopoly session +json
		+math +memsys5 update-limit editline readline gcov"

DEPEND="
	app-lang/tcl
	lib-core/readline
	lib-core/zlib
"

src_configure() {
	filter-flags -fuse-ld=lld
	# Support detection of misuse of SQLite API.
	# https://sqlite.org/compile.html#enable_api_armor
	append-cppflags -DSQLITE_ENABLE_API_ARMOR

	# Support bytecode and tables_used virtual tables.
	# https://sqlite.org/compile.html#enable_bytecode_vtab
	# https://sqlite.org/bytecodevtab.html
	append-cppflags -DSQLITE_ENABLE_BYTECODE_VTAB

	# Support column metadata functions.
	# https://sqlite.org/compile.html#enable_column_metadata
	# https://sqlite.org/c3ref/column_database_name.html
	append-cppflags -DSQLITE_ENABLE_COLUMN_METADATA

	# Support sqlite_dbpage virtual table.
	# https://sqlite.org/compile.html#enable_dbpage_vtab
	# https://sqlite.org/dbpage.html
	append-cppflags -DSQLITE_ENABLE_DBPAGE_VTAB

	# Support sqlite3_serialize() and sqlite3_deserialize() functions.
	# https://sqlite.org/compile.html#enable_deserialize
	# https://sqlite.org/c3ref/serialize.html
	# https://sqlite.org/c3ref/deserialize.html
	append-cppflags -DSQLITE_ENABLE_DESERIALIZE

	# Support comments in output of EXPLAIN.
	# https://sqlite.org/compile.html#enable_explain_comments
	append-cppflags -DSQLITE_ENABLE_EXPLAIN_COMMENTS

	# Support hidden columns.
	append-cppflags -DSQLITE_ENABLE_HIDDEN_COLUMNS

	# Support sqlite3_normalized_sql() function.
	# https://sqlite.org/c3ref/expanded_sql.html
	append-cppflags -DSQLITE_ENABLE_NORMALIZE

	# Support sqlite_offset() function.
	# https://sqlite.org/compile.html#enable_offset_sql_func
	# https://sqlite.org/lang_corefunc.html#sqlite_offset
	append-cppflags -DSQLITE_ENABLE_OFFSET_SQL_FUNC

	# Support pre-update hook functions.
	# https://sqlite.org/compile.html#enable_preupdate_hook
	# https://sqlite.org/c3ref/preupdate_count.html
	append-cppflags -DSQLITE_ENABLE_PREUPDATE_HOOK

	# Support Resumable Bulk Update extension.
	# https://sqlite.org/compile.html#enable_rbu
	# https://sqlite.org/rbu.html
	append-cppflags -DSQLITE_ENABLE_RBU

	# Support scan status functions.
	# https://sqlite.org/compile.html#enable_stmt_scanstatus
	# https://sqlite.org/c3ref/stmt_scanstatus.html
	# https://sqlite.org/c3ref/stmt_scanstatus_reset.html
	append-cppflags -DSQLITE_ENABLE_STMT_SCANSTATUS

	# Support sqlite_stmt virtual table.
	# https://sqlite.org/compile.html#enable_stmtvtab
	# https://sqlite.org/stmt.html
	append-cppflags -DSQLITE_ENABLE_STMTVTAB

	# Support unknown() function.
	# https://sqlite.org/compile.html#enable_unknown_sql_function
	append-cppflags -DSQLITE_ENABLE_UNKNOWN_SQL_FUNCTION

	# Support unlock notification.
	# https://sqlite.org/compile.html#enable_unlock_notify
	# https://sqlite.org/c3ref/unlock_notify.html
	# https://sqlite.org/unlock_notify.html
	append-cppflags -DSQLITE_ENABLE_UNLOCK_NOTIFY

	# Support soundex() function.
	# https://sqlite.org/compile.html#soundex
	# https://sqlite.org/lang_corefunc.html#soundex
	append-cppflags -DSQLITE_SOUNDEX

	# Support URI filenames.
	# https://sqlite.org/compile.html#use_uri
	# https://sqlite.org/uri.html
	append-cppflags -DSQLITE_USE_URI

	local myconf=(
		$(use_enable static-libs static)
		--enable-load-extension
		--enable-threadsafe
		--disable-fts3
		--disable-fts4
		--disable-memsys3
		$(use_enable debug)
		$(use_enable tempstore)
		$(use_enable fts5)
		$(use_enable rtree)
		$(use_enable geopoly)
		$(use_enable session)
		$(use_enable json)
		$(use_enable math)
		$(use_enable memsys5)
		$(use_enable update-limit)
		$(use_enable editline)
		$(use_enable readline)
		$(use_enable gcov)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

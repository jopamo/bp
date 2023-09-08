# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="A SQL Database Engine in a C Library"
HOMEPAGE="https://sqlite.org/"

printf -v SRC_PV "%u%02u%02u%02u" $(ver_rs 1- " ")
SRC_URI="https://sqlite.org/2023/${PN}-src-${SRC_PV}.zip"
S="${WORKDIR}/${PN}-src-${SRC_PV}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	app-lang/tcl
	lib-core/readline
	lib-core/zlib
"

src_configure() {
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

	# Support dbstat virtual table.
	# https://sqlite.org/compile.html#enable_dbstat_vtab
	# https://sqlite.org/dbstat.html
	append-cppflags -DSQLITE_ENABLE_DBSTAT_VTAB

	# Support sqlite3_serialize() and sqlite3_deserialize() functions.
	# https://sqlite.org/compile.html#enable_deserialize
	# https://sqlite.org/c3ref/serialize.html
	# https://sqlite.org/c3ref/deserialize.html
	append-cppflags -DSQLITE_ENABLE_DESERIALIZE

	# Support comments in output of EXPLAIN.
	# https://sqlite.org/compile.html#enable_explain_comments
	append-cppflags -DSQLITE_ENABLE_EXPLAIN_COMMENTS

	# Support Full-Text Search
	# https://sqlite.org/compile.html#enable_fts3
	# https://sqlite.org/compile.html#enable_fts3_parenthesis
	# https://sqlite.org/compile.html#enable_fts4
	# https://sqlite.org/compile.html#enable_fts5
	# https://sqlite.org/fts3.html
	# https://sqlite.org/fts5.html
	append-cppflags -DSQLITE_ENABLE_FTS3 -DSQLITE_ENABLE_FTS3_PARENTHESIS -DSQLITE_ENABLE_FTS4

	# Support hidden columns.
	append-cppflags -DSQLITE_ENABLE_HIDDEN_COLUMNS

	# Support memsys5 memory allocator.
	# https://sqlite.org/compile.html#enable_memsys5
	# https://sqlite.org/malloc.html#memsys5
	append-cppflags -DSQLITE_ENABLE_MEMSYS5

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

	# Support R*Trees.
	# https://sqlite.org/compile.html#enable_rtree
	# https://sqlite.org/compile.html#enable_geopoly
	# https://sqlite.org/rtree.html
	# https://sqlite.org/geopoly.html
	append-cppflags -DSQLITE_ENABLE_RTREE -DSQLITE_ENABLE_GEOPOLY

	# Support Session extension.
	# https://sqlite.org/compile.html#enable_session
	# https://sqlite.org/sessionintro.html
	append-cppflags -DSQLITE_ENABLE_SESSION

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

	# Support LIMIT and ORDER BY clauses on DELETE and UPDATE statements.
	# https://sqlite.org/compile.html#enable_update_delete_limit
	# https://sqlite.org/lang_delete.html#optional_limit_and_order_by_clauses
	# https://sqlite.org/lang_update.html#optional_limit_and_order_by_clauses
	append-cppflags -DSQLITE_ENABLE_UPDATE_DELETE_LIMIT

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
		--enable-fts5
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

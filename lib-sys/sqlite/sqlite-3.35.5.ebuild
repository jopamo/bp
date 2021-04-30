# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="$(ver_cut 1)$(ver_cut 2)0$(ver_cut 3)00"

DESCRIPTION="A SQL Database Engine in a C Library"
HOMEPAGE="https://sqlite.org/"
SRC_URI="https://www.sqlite.org/2021/sqlite-src-${MY_PV}.zip"
S="${WORKDIR}/sqlite-src-${MY_PV}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
		dev-lang/tcl
		lib-sys/readline
		lib-sys/zlib
"

src_configure() {
	export CPPFLAGS="$CPPFLAGS \
		-DSQLITE_ENABLE_COLUMN_METADATA=1 \
		-DSQLITE_ENABLE_UNLOCK_NOTIFY=1 \
		-DSQLITE_ENABLE_DBSTAT_VTAB=1 \
		-DSQLITE_SECURE_DELETE=1 \
		-DSQLITE_ENABLE_FTS3_TOKENIZER=1 \
		-DSQLITE_ENABLE_STMTVTAB \
		-DSQLITE_MAX_VARIABLE_NUMBER=250000 \
		-DSQLITE_MAX_EXPR_DEPTH=10000"

	local myconf=(
		$(use_enable static-libs static)
		--disable-amalgamation
		--enable-fts3
		--enable-fts4
		--enable-fts5
		--enable-rtree
		--enable-json1
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

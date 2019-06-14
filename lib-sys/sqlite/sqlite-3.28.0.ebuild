# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

MY_PV="$(ver_cut 1)$(ver_cut 2)$(ver_cut 3)000"

DESCRIPTION="A SQL Database Engine in a C Library"
HOMEPAGE="https://sqlite.org/"
SRC_URI="https://www.sqlite.org/2019/sqlite-src-${MY_PV}.zip"
S="${WORKDIR}/sqlite-src-${MY_PV}"

LICENSE="public-domain"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="dev-lang/tcl"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		--enable-fts5
		CFLAGS="${CFLAGS} \
		-DSQLITE_ENABLE_RTREE=1 \
		-DSQLITE_ENABLE_FTS3=1 \
		-DSQLITE_ENABLE_FTS4=1 \
		-DSQLITE_ENABLE_COLUMN_METADATA=1 \
		-DSQLITE_ENABLE_UNLOCK_NOTIFY=1 \
		-DSQLITE_ENABLE_DBSTAT_VTAB=1 \
		-DSQLITE_SECURE_DELETE=1 \
		-DSQLITE_ENABLE_FTS3_TOKENIZER=1"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

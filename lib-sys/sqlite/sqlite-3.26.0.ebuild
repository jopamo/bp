# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal versionator

MY_PV="$(printf "%u%02u%02u%02u" $(get_version_components))"

DESCRIPTION="A SQL Database Engine in a C Library"
HOMEPAGE="https://sqlite.org/"
SRC_URI="https://www.sqlite.org/2018/sqlite-src-${MY_PV}.zip"
S="${WORKDIR}/sqlite-src-${MY_PV}"

LICENSE="public-domain"
SLOT="3"
KEYWORDS="amd64 arm64 x86"
IUSE="debug doc icu +readline secure-delete static-libs test tools"

RDEPEND="icu? ( lib-dev/icu:0=[${MULTILIB_USEDEP}] )
	readline? ( lib-sys/readline:0=[${MULTILIB_USEDEP}] )"
DEPEND="dev-lang/tcl"

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		--enable-fts5
		CFLAGS="${CFLAGS}
		-DSQLITE_ENABLE_FTS4=1
		-DSQLITE_ENABLE_COLUMN_METADATA=1
		-DSQLITE_ENABLE_UNLOCK_NOTIFY=1
		-DSQLITE_ENABLE_DBSTAT_VTAB=1
		-DSQLITE_SECURE_DELETE=1
		-DSQLITE_ENABLE_FTS3_TOKENIZER=1"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools versionator

MY_PV="$(printf "%u%02u%02u%02u" $(get_version_components))"

DESCRIPTION="A SQL Database Engine in a C Library"
HOMEPAGE="https://sqlite.org/"
SRC_URI="https://www.sqlite.org/2018/sqlite-src-${MY_PV}.zip"
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
		CFLAGS="${CFLAGS}
		-DSQLITE_ENABLE_RTREE=1"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

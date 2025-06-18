# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="port of netbsd's curses library for usage on Linux systems"
HOMEPAGE="https://github.com/sabotage-linux/netbsd-curses"

SNAPSHOT=51d179dad861640caeb76674b5908ccd79f04fae
SRC_URI="https://github.com/sabotage-linux/netbsd-curses/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/netbsd-curses-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="!lib-core/ncurses"

src_compile() {
	emake CFLAGS="${CFLAGS}" DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr all

	use static-libs && emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS} -static" \
		DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr all-static
}

src_install() {
	emake CFLAGS="${CFLAGS}" DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr all install

	use static-libs && emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS} -static" \
		DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr all-static install-static

	cleanup_install
}

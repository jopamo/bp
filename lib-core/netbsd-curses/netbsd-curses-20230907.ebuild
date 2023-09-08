# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="port of netbsd's curses library for usage on Linux systems"
HOMEPAGE="https://github.com/sabotage-linux/netbsd-curses"
EGIT_REPO_URI="https://github.com/sabotage-linux/netbsd-curses"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sabotage-linux/netbsd-curses.git"
else
	SNAPSHOT=8fa4b821c0916039b1f026c16d72cebbf4555815
	SRC_URI="https://github.com/sabotage-linux/netbsd-curses/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="BSD"
SLOT="0"

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

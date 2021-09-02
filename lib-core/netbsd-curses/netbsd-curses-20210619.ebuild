# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="port of netbsd's curses library for usage on Linux systems"
HOMEPAGE="https://github.com/sabotage-linux/netbsd-curses"
EGIT_REPO_URI="https://github.com/sabotage-linux/netbsd-curses"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sabotage-linux/netbsd-curses.git"
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=5874f9b1ced9c29d7d590d95e254b252f657a160
	SRC_URI="https://github.com/sabotage-linux/netbsd-curses/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="BSD"
SLOT="0"

IUSE="static"

DEPEND="!lib-core/ncurses"

src_compile() {
	emake CFLAGS="${CFLAGS}" DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr all

	use static && emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS} -static" \
		DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr all-static
}

src_install() {
	emake CFLAGS="${CFLAGS}" DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr all install

	use static && emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS} -static" \
		DESTDIR="${ED}" PREFIX="${EPREFIX}"/usr all-static install-static

	cleanup_install
}

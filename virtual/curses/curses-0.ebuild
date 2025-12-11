# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="curses implementation virtual"

SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="netbsd-curses static-libs"

RDEPEND="netbsd-curses? (
			lib-core/netbsd-curses[static-libs?]
			!lib-core/ncurses[static-libs?]
)
		!netbsd-curses? (
			lib-core/ncurses[static-libs?]
			!lib-core/netbsd-curses[static-libs?]
)"

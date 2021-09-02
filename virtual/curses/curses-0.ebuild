# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="curses implementation virtual."

SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="netbsd-curses"

RDEPEND="netbsd-curses? (
			lib-core/netbsd-curses
			!lib-core/ncurses
)
		!netbsd-curses? (
			lib-core/ncurses
			!lib-core/netbsd-curses
)"

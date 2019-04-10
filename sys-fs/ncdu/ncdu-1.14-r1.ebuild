# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="http://dev.yorhel.nl/ncdu/"
SRC_URI="http://dev.yorhel.nl/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-sys/ncurses
"
DEPEND="
	${RDEPEND}
	dev-util/pkgconfig
"

PATCHES=( 	${FILESDIR}/8e021a46ee2d455c8c677a7eb982b56c3c408942.patch
			${FILESDIR}/ec0de4afa8f6119a737f731433134bed4fc48f32.patch
		)

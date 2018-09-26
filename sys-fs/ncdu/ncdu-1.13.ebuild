# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="http://dev.yorhel.nl/ncdu/"
SRC_URI="http://dev.yorhel.nl/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	lib-sys/ncurses:0=[unicode]
"
DEPEND="
	${RDEPEND}
	dev-util/pkgconfig
"

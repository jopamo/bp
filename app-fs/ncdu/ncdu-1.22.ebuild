# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="http://dev.yorhel.nl/ncdu/"

SRC_URI="https://dev.yorhel.nl/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="virtual/curses"

src_prepare() {
	default
	eautoreconf
}

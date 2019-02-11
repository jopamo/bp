# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
HOMEPAGE="http://www.roland-riegel.de/nload/index.html"
EGIT_REPO_URI="https://github.com/rolandriegel/nload.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=lib-sys/ncurses-5.2:0="
DEPEND="
	${RDEPEND}
	dev-util/pkgconfig
"
src_prepare() {
	eautoreconf
	default
}

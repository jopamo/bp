# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="http://dev.yorhel.nl/ncdu/"
EGIT_REPO_URI="https://g.blicky.net/ncdu.git/"
EGIT_MIN_CLONE_TYPE=single

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-sys/ncurses"

src_prepare() {
	default
	eautoreconf
}

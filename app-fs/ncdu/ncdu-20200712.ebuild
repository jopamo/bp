# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="http://dev.yorhel.nl/ncdu/"

SNAPSHOT=a216bc2d35b6edf4dadf55350f09d7cbf229fbf7
SRC_URI="https://github.com/rofl0r/ncdu/archive/${SNAPSHOT}.tar.gz -> ncdu-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ncdu-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="virtual/curses"

src_prepare() {
	default
	eautoreconf
}

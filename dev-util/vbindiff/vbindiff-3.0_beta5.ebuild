# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Visual binary diff utility"
HOMEPAGE="https://www.cjmweb.net/vbindiff/"
SRC_URI="https://www.cjmweb.net/vbindiff/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-sys/ncurses:0="
DEPEND="${RDEPEND}"

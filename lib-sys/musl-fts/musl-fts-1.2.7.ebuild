# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION=" implements the fts functions which are missing in musl libc."
HOMEPAGE="http://www.musl-libc.org/"
SRC_URI="https://github.com/void-linux/musl-fts/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Indent program source files"
HOMEPAGE="https://www.gnu.org/software/indent/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	sed -i -e '/AM_CFLAGS/s:-Werror::g' src/Makefile.{am,in} || die
}

src_test() {
	emake -C regression/
}

src_install() {
	default
	rm -rf "${ED}"/usr/doc
}

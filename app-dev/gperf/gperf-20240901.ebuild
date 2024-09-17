# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A perfect hash function generator"
HOMEPAGE="https://www.gnu.org/software/gperf/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
#fails to build
#KEYWORDS="amd64 arm64"

src_prepare() {
	sed -i \
		-e "/^CPPFLAGS /s:=:+=:" \
		*/Makefile.in || die

	default
}

src_configure() {
	default
	sed -i '/doc/d' Makefile || die
}

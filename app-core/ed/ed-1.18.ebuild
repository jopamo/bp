# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs autotools unpacker

DESCRIPTION="Your basic line editor"
HOMEPAGE="https://www.gnu.org/software/ed/"
SRC_URI="mirror://gnu/ed/${P}.tar.lz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-build/texinfo"

src_prepare() {
	default
	sed -i "s|-O2|${CFLAGS}|g" configure
}

src_configure() {
	${S}/configure --prefix="${EPREFIX}"/usr
}

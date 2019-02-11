# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs autotools

DESCRIPTION="Your basic line editor"
HOMEPAGE="https://www.gnu.org/software/ed/"
SRC_URI="http://fossies.org/linux/privat/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="sys-app/texinfo"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		)
	econf ${myconf[@]}
}

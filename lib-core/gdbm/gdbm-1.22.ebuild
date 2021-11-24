# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Standard GNU database libraries"
HOMEPAGE="https://www.gnu.org/software/gdbm/"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	app-core/bash
	lib-core/readline
"

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--with-readline
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

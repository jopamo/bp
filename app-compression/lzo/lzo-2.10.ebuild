# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An extremely fast compression and decompression library"
HOMEPAGE="http://www.oberhumer.com/opensource/lzo/"
SRC_URI="http://www.oberhumer.com/opensource/lzo/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf=(
		--enable-shared
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

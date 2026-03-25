# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="An extremely fast compression and decompression library"
HOMEPAGE="https://www.oberhumer.com/opensource/lzo/"
SRC_URI="https://www.oberhumer.com/opensource/lzo/download/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_configure() {
	qa-policy-configure

	local myconf=(
		--enable-shared
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake check
}

src_install() {
	default

	qa-policy-install
}

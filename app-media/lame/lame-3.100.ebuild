# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="http://lame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

DEPEND="dev-lang/nasm"

src_prepare() {
	default
	AT_M4DIR=. eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable debug debug norm)
		--disable-mp3x
		--enable-dynamic-frontends
		--enable-nasm
		--disable-frontend
		--disable-mp3rtp
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" pkghtmldir="${EPREFIX}/usr/share/doc/${PF}/html" install
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="https://www.mpg123.org/"
SRC_URI="https://www.mpg123.org/download/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

DEPEND="
	xgui-tools/alsa-lib
	xgui-misc/pulseaudio"

BDEPEND="
	app-build/libtool
	app-dev/pkgconf
"

src_prepare() {
	default
	append-flags "-fpermissive -std=gnu17"
}

src_configure() {
	local myconf=(
		$(use_enable ipv6)
		--disable-id3v2
		--enable-int-quality
		--enable-network
		--with-audio="alsa pulse"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

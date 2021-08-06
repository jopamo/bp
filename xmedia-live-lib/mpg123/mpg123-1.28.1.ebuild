# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="https://www.mpg123.org/"
SRC_URI="https://www.mpg123.org/download/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

DEPEND="
	xmedia-live-lib/alsa-lib
	xmedia-live-app/pulseaudio"

BDEPEND="
	sys-devel/libtool
	dev-util/pkgconf"

append-cflags -D_GNU_SOURCE

src_prepare() {
	sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-network
		$(use_enable ipv6)
		--disable-id3v2
		--enable-int-quality
		--with-audio="alsa pulse"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

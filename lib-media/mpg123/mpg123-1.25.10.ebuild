# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic multilib-minimal

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="https://www.mpg123.org/"
SRC_URI="https://www.mpg123.org/download/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa ipv6 pulseaudio"

RDEPEND="lib-dev/libltdl:0
	alsa? ( lib-media/alsa-lib )
	pulseaudio? ( app-media/pulseaudio )"

DEPEND="${RDEPEND}
	sys-devel/libtool
	dev-util/pkgconfig"

pkg_setup() {
	append-cflags -D_GNU_SOURCE
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-network
		$(use_enable ipv6)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

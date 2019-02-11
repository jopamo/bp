# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils flag-o-matic

DESCRIPTION="ALSA extra plugins"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="ftp://ftp.alsa-project.org/pub/plugins/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug ffmpeg libav libsamplerate pulseaudio"

RDEPEND="
	>=lib-media/alsa-lib-${PV}
	ffmpeg? (
		libav? ( app-media/libav:= )
		!libav? ( app-media/ffmpeg:0= )
	)
	libsamplerate? ( >=lib-media/libsamplerate-0.1.8-r1 )
	pulseaudio? ( >=app-media/pulseaudio-2.1-r1 )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	default

	sed -i \
		-e '/AM_CFLAGS/s:-Wall:-DNDEBUG -Wall:' \
		pulse/Makefile.am || die

	eautoreconf
}

src_configure() {
	use debug || append-cppflags -DNDEBUG

	ECONF_SOURCE=${S} \
	econf \
		$(use_enable ffmpeg avcodec) \
		$(use_enable libsamplerate samplerate) \
		$(use_enable pulseaudio) \
		--with-speex=no \
		--disable-speexdsp \
		--disable-oss \
		--disable-arcamav \
		--disable-usbstream
}

src_install_all() {

	if use pulseaudio; then
		# install ALSA configuration files
		# making PA to be used by alsa clients
		insinto /usr/share/alsa
		doins "${FILESDIR}"/pulse-default.conf
		insinto /usr/share/alsa/alsa.conf.d
		doins "${FILESDIR}"/51-pulseaudio-probe.conf
		# bug #410261, comment 5+
		# seems to work fine without any path
		sed -i \
			-e "s:/usr/lib/alsa-lib/::" \
			"${ED}"/usr/share/alsa/alsa.conf.d/51-pulseaudio-probe.conf || die #410261
	fi

	find "${ED}" -name "*.la" -delete || die
}

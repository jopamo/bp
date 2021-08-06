# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="ALSA extra plugins"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="https://www.alsa-project.org/files/pub/plugins/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ffmpeg libsamplerate pulseaudio"

DEPEND="
	xmedia-live-lib/speexdsp
	>=xmedia-live-lib/alsa-lib-${PV}
	ffmpeg? ( xmedia-live-app/ffmpeg:0= )
	libsamplerate? ( >=xmedia-live-lib/libsamplerate-0.1.8-r1 )
	pulseaudio? ( >=xmedia-live-app/pulseaudio-2.1-r1 )
"

src_prepare() {
	default

	sed -i \
		-e '/AM_CFLAGS/s:-Wall:-DNDEBUG -Wall:' \
		pulse/Makefile.am || die

	eautoreconf
}

src_configure() {
	use debug || append-cppflags -DNDEBUG

	local myconf=(
		$(use_enable ffmpeg libav)
		$(use_enable libsamplerate samplerate)
		$(use_enable pulseaudio)
		--with-speex=lib
		--enable-speexdsp
		--disable-oss
		--disable-arcamav
		--disable-usbstream
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
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
}

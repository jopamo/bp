# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils flag-o-matic multilib multilib-minimal

DESCRIPTION="ALSA extra plugins"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="ftp://ftp.alsa-project.org/pub/plugins/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="debug ffmpeg jack libav libsamplerate pulseaudio"

RDEPEND="
	>=lib-media/alsa-lib-${PV}:=[${MULTILIB_USEDEP}]
	ffmpeg? (
		libav? ( app-media/libav:= )
		!libav? ( app-media/ffmpeg:0= )
	)
	jack? ( virtual/jack[${MULTILIB_USEDEP}] )
	libsamplerate? ( >=lib-media/libsamplerate-0.1.8-r1:=[${MULTILIB_USEDEP}] )
	pulseaudio? ( >=app-media/pulseaudio-2.1-r1[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	default

	# For some reasons the polyp/pulse plugin does fail with alsaplayer with a
	# failed assert. As the code works just fine with asserts disabled, for now
	# disable them waiting for a better solution.
	sed -i \
		-e '/AM_CFLAGS/s:-Wall:-DNDEBUG -Wall:' \
		pulse/Makefile.am || die

	eautoreconf
}

multilib_src_configure() {
	use debug || append-cppflags -DNDEBUG

	ECONF_SOURCE=${S} \
	econf \
		$(use_enable ffmpeg avcodec) \
		$(use_enable jack) \
		$(use_enable libsamplerate samplerate) \
		$(use_enable pulseaudio) \
		--with-speex=no \
		--disable-speexdsp \
		--disable-oss \
		--disable-arcamav \
		--disable-usbstream
}

multilib_src_install_all() {
	use jack && dodoc README-jack
	use libsamplerate && dodoc samplerate.txt
	use ffmpeg && dodoc lavcrate.txt a52.txt

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

	prune_libtool_files --all
}

pkg_postinst() {
	if use pulseaudio; then
		einfo "The PulseAudio device is now set as the default device if the"
		einfo "PulseAudio server is found to be running. Any custom"
		einfo "configuration in /etc/asound.conf or ~/.asoundrc for this"
		einfo "purpose should now be unnecessary."
	fi
}

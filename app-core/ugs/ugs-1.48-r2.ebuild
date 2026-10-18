# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="helper scripts"
HOMEPAGE="https://1g4.org"

LICENSE="MIT"
SLOT="0"
S=${WORKDIR}

KEYWORDS="amd64 arm64"

IUSE="ipv6 test video"

BDEPEND="test? ( app-lang/python virtual/ssl )"
RDEPEND="
	virtual/ssl
	video? (
		>=xmedia-app/ffmpeg-20261004[avcodec,avfilter,avformat,ffmpeg,swresample]
		xmedia-app/ffmpeg-normalize
	)
"
RESTRICT="!test? ( test )"

src_test() {
	python3 "${FILESDIR}/test_mkimg.py" || die "mkimg tests failed"
	python3 "${FILESDIR}/test_lighttpd_certs.py" || die "lighttpd certificate tests failed"
}

src_install() {
	# Optional bash helper fragments
	insinto /etc/bash/bashrc.d
	doins "${FILESDIR}/bashrc/eth.sh"

	local bin_utils=(
		1g4-finalize-install
		1g4-rootfs-policy
		1g4-system-setup
		dslam
		efixperm
		lighttpd_certs
		mkheaders
		mkimg
		build
		mkstage
		ubuntu_kernel
		xbkup
		xchroot
		zgrep
	)
	for f in "${bin_utils[@]}"; do
		dobin "${FILESDIR}/bin/$f"
	done

	if use ipv6; then
		sed -i \
			-e 's/ONEG4_SETUP_NETWORKD_DHCP:-ipv4/ONEG4_SETUP_NETWORKD_DHCP:-yes/' \
			-e 's/ONEG4_SETUP_NETWORKD_IPV6_ACCEPT_RA:-no/ONEG4_SETUP_NETWORKD_IPV6_ACCEPT_RA:-yes/' \
			"${ED}/usr/bin/1g4-system-setup" || die
		sed -i \
			-e 's/write_config_var ONEG4_SETUP_NETWORKD_DHCP ipv4/write_config_var ONEG4_SETUP_NETWORKD_DHCP yes/' \
			"${ED}/usr/bin/1g4-finalize-install" || die
	fi

	insinto /usr/lib/systemd/system
	insopts -m 0644
	local systemd_services=(
		daily-reboot.service
		xdp-drop@.service
		xdp-ddos@.service
	)
	for f in "${systemd_services[@]}"; do
		doins "${FILESDIR}/services/$f"
	done

	local systemd_timers=(
		daily-reboot.timer
	)
	for f in "${systemd_timers[@]}"; do
		doins "${FILESDIR}/timers/$f"
	done

	if use video ; then
		local video_bins=(
			mkv2aac mkvengonly mux_mp4 normalize_audio x265_anime x265_film
		)
		for f in "${video_bins[@]}"; do
			dobin "${FILESDIR}/video/$f"
		done
	fi
}

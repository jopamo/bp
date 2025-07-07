# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="helper scripts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="video"

S=${WORKDIR}

src_install() {
	# Bash config scripts (from files/bashrc/)
	insinto /etc/bash/bashrc.d
	doins "${FILESDIR}/bashrc/1g4.sh"
	doins "${FILESDIR}/bashrc/eth.sh"
	doins "${FILESDIR}/bashrc/emoji.sh"

	insinto /etc/bash
	doins "${FILESDIR}/bash_logout"
	doins "${FILESDIR}/bashrc/bashrc"

	# Inputrc is not shown in your tree, add if present
	if [[ -f "${FILESDIR}/inputrc" ]]; then
		insopts -m 0644
		insinto /etc
		doins "${FILESDIR}/inputrc"
		insinto /usr/share/factory/etc
		doins "${FILESDIR}/inputrc"
	fi

	local bin_utils=(
		dslam
		eclass_import
		efixperm
		emirror
		hosts_bump
		lighttpd_certs
		mkheaders
		mkimg
		mkstage
		ubuntu_kernel
		xbkup
		xchroot
		zgrep
	)
	for f in "${bin_utils[@]}"; do
		dobin "${FILESDIR}/bin/$f"
	done

	insinto /usr/lib/systemd/system
	insopts -m 0644
	local systemd_services=(
		daily-reboot.service
		hosts_bump.service
		xdp-loader@.service
	)
	for f in "${systemd_services[@]}"; do
		doins "${FILESDIR}/services/$f"
	done

	local systemd_timers=(
		daily-reboot.timer
		hosts_bump.timer
	)
	for f in "${systemd_timers[@]}"; do
		doins "${FILESDIR}/timers/$f"
	done

	if use video ; then
		local video_bins=(
			mkv2aac mux_mp4 normalize_audio
			x264_anime x264_film x265 x265_anime x265_film
		)
		for f in "${video_bins[@]}"; do
			dobin "${FILESDIR}/video/$f"
		done
	fi
}

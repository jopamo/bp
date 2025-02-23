# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="helper scripts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="video"

S=${WORKDIR}

src_install() {
	insinto /etc/bash/bashrc.d
	doins "${FILESDIR}"/1g4.sh

	insinto /etc/bash
	doins "${FILESDIR}"/{bash_logout,bashrc}

	insopts -m 0644
	insinto /etc
	doins "${FILESDIR}"/inputrc
	insinto /usr/share/factory/etc
	doins "${FILESDIR}"/inputrc

	#bin files
	for f in ix mktarballs efixperm prettybash ; do
		dobin "${FILESDIR}"/bin/$f
	done

	for f in upDay.skel ; do
			insinto /usr/share/ugscripts
			doins "${FILESDIR}"/bin/$f
	done

	for f in hosts_bump eclass_import emirror lighttpd_certs \
		mkheaders mkimg mkmini mkstage xbkup upApp upAll upBrowsers \
		upPython upGit xchroot ; do
			dobin "${FILESDIR}"/bin/$f
	done

	# systemd services
	for f in {hosts_bump,daily-reboot}.service ; do
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/services/$f
	done

	for f in {hosts_bump,daily-reboot}.timer ; do
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/timers/$f
	done

	if use video ; then
		for f in mkv2aac mux_mp4 normalize_audio x264_anime x264_film \
			x265_anime x265_film x265 ; do
				dobin "${FILESDIR}"/video/$f
		done
	fi
}

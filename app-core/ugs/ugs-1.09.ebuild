# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Misc scripts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="video"

S=${WORKDIR}

src_install() {
	insinto /etc/bash/bashrc.d
	doins "${FILESDIR}"/alias.sh
	doins "${FILESDIR}"/1g4.sh

	#bin files
	for f in ix mktarballs efixperm prettybash ; do
		dobin "${FILESDIR}"/bin/$f
	done

	#sbin files
	for f in upDay.skel ; do
			insinto /usr/share/ugscripts
			doins "${FILESDIR}"/sbin/$f
	done

	for f in hosts_bump eclass_import emirror lighttpd_certs \
		mkheaders mkimg mkmini mkstage xbkup upApp upAll upBrowsers \
		upPython upGit xchroot ; do
			dosbin "${FILESDIR}"/sbin/$f
	done

	for f in hosts_bump.service ; do
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/services/$f
	done

	for f in hosts_bump.timer ; do
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
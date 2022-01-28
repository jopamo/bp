# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Misc scripts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="video"

S=${WORKDIR}

src_install() {
	#bin files
	for f in ix ; do
		dobin "${FILESDIR}"/bin/$f
	done

	#sbin files
	for f in efixperm emirror esync eup lighttpd_certs \
		mkheaders mkimg mkmini mkstage mktarballs xbkup xchroot ; do
			dosbin "${FILESDIR}"/sbin/$f
	done

	if use video ; then
		for f in mkv2aac mux_mp4 normalize_audio x264_anime x264_film \
			x265_anime x265_film ; do
				dobin "${FILESDIR}"/video/$f
		done
	fi
}

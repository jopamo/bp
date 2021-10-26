# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfo"
EGIT_REPO_URI="https://github.com/MediaArea/MediaInfo"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xmedia-live-lib/libmediainfo
	xmedia-live-lib/libzen
	lib-core/zlib
"

S="${S}/Project/GNU/CLI"

src_prepare() {
	default
	sed -i -e "s:-O2::" configure.ac || die
	eautoreconf
}

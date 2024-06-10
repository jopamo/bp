# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfo"

SNAPSHOT=029a950c43967cc717a5d04e01a037a6a8fb13ca
SRC_URI="https://github.com/MediaArea/MediaInfo/archive/${SNAPSHOT}.tar.gz -> MediaInfo-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/MediaInfo-${SNAPSHOT}/Project/GNU/CLI/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xmedia-lib/libmediainfo
	xmedia-lib/libzen
	lib-core/zlib
"

src_prepare() {
	default
	sed -i -e "s:-O2::" configure.ac || die
	eautoreconf
}

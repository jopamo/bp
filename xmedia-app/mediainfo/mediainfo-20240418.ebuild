# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfo"

SNAPSHOT=11e34998f749a2236dab66beb3bf7a1db9246e5d
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
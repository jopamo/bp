# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfo"

SNAPSHOT=a66b068b25ab814535ccce1fbd9be2fbe82beaa8
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

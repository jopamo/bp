# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfo"
SNAPSHOT=98cef65561ddc961ccb774b4b625f8a8c1546474
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
	cd "${WORKDIR}/MediaInfo-${SNAPSHOT}"
	cp "${WORKDIR}/MediaInfo-${SNAPSHOT}/Project/GNU/CLI/AddThisToRoot_CLI_compile.sh" c.sh
	./c.sh || die
	cd "${S}"
	default
	sed -i -e "s:-O2::" configure.ac || die
	eautoreconf

	append-flags -lcrypto
	filter-flags -Wl,-z,defs -flto*
}

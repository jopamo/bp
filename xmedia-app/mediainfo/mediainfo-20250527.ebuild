# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfo"

SNAPSHOT=f28733cb7379e42c441b6d4b2da418495ac2dcab
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

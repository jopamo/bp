# Distributed under the terms of the GNU General Public License v2

inherit autotools flag-o-matic

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfo"
SNAPSHOT=f94a640d95a91a93097ce6b8200ceeab60a7299e
SRC_URI="https://github.com/MediaArea/MediaInfo/archive/${SNAPSHOT}.tar.gz -> MediaInfo-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/MediaInfo-${SNAPSHOT}/Project/GNU/CLI/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xmedia-lib/libmediainfo
	>=xmedia-lib/libzen-20261112
	lib-core/zlib
"

PATCHES=( "${FILESDIR}/mediainfo-tests-check-generated-locale.patch" )

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

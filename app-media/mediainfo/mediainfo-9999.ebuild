# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfo"
EGIT_REPO_URI="https://github.com/MediaArea/MediaInfo.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-sys/zlib
	>=lib-media/libzen-0.4.37
	lib-media/libmediainfo"

DEPEND="${RDEPEND}
	dev-util/pkgconf"

S=${WORKDIR}/${P}/Project/GNU/CLI

src_prepare() {
	eapply_user
	sed -i -e "s:-O2::" configure.ac || die
	eautoreconf
}

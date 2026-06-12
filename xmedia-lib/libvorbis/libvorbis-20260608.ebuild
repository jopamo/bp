# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="The Ogg Vorbis sound file format library"
HOMEPAGE="https://xiph.org/vorbis/"
SNAPSHOT=e3c9861ff096d52378e131ff8c334552e09cdffa
SRC_URI="https://github.com/xiph/vorbis/archive/${SNAPSHOT}.tar.gz -> vorbis-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/vorbis-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="xmedia-lib/libogg"

src_configure() {
	qa-policy-configure
	cmake_src_configure
}

src_install() {
	cmake_src_install
	qa-policy-install
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The Ogg Vorbis sound file format library"
HOMEPAGE="https://xiph.org/vorbis/"

SNAPSHOT=84c023699cdf023a32fa4ded32019f194afcdad0
SRC_URI="https://github.com/xiph/vorbis/archive/${SNAPSHOT}.tar.gz -> vorbis-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/vorbis-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="xmedia-lib/libogg"

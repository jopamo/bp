# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="a powerful tool for video post-production"
HOMEPAGE="http://avs-plus.net/"
SNAPSHOT=e922883703abfee54d3fcc55d3fc8dea6618d871
SRC_URI="https://github.com/AviSynth/AviSynthPlus/archive/${SNAPSHOT}.tar.gz -> AviSynthPlus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/AviSynthPlus-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

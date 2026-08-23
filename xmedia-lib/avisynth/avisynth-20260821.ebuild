# Distributed under the terms of the GNU General Public License v2

inherit cmake

DESCRIPTION="a powerful tool for video post-production"
HOMEPAGE="http://avs-plus.net/"
SNAPSHOT=1ffeb08c726b2af5448225ad27686248e68f2645
SRC_URI="https://github.com/AviSynth/AviSynthPlus/archive/${SNAPSHOT}.tar.gz -> AviSynthPlus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/AviSynthPlus-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

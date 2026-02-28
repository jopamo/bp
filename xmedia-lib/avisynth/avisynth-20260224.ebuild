# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="a powerful tool for video post-production"
HOMEPAGE="http://avs-plus.net/"
SNAPSHOT=32431c4af3df2d554e0b90342ece330410b70293
SRC_URI="https://github.com/AviSynth/AviSynthPlus/archive/${SNAPSHOT}.tar.gz -> AviSynthPlus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/AviSynthPlus-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="a powerful tool for video post-production."
HOMEPAGE="http://avs-plus.net/"
SNAPSHOT=8cb6ddd72f4d78e8d86fcd34dc4bc4b67c819cf1
SRC_URI="https://github.com/AviSynth/AviSynthPlus/archive/${SNAPSHOT}.tar.gz -> AviSynthPlus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/AviSynthPlus-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

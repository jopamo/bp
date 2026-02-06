# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="a powerful tool for video post-production"
HOMEPAGE="http://avs-plus.net/"
SNAPSHOT=8f2a77887874a9c78fc3524b1feafbb69011bfc2
SRC_URI="https://github.com/AviSynth/AviSynthPlus/archive/${SNAPSHOT}.tar.gz -> AviSynthPlus-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/AviSynthPlus-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

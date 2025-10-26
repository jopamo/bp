# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Simple Qt archive manager based on libarchive"
HOMEPAGE="https://github.com/tsujan/Arqiver.git"
SNAPSHOT=f19b7553dc6efb1dd0a722cb67c3402ee856e8fd
SRC_URI="https://github.com/tsujan/Arqiver/archive/${SNAPSHOT}.tar.gz -> Arqiver-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Arqiver-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

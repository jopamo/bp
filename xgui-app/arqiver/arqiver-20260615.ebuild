# Distributed under the terms of the GNU General Public License v2

inherit cmake xdg

DESCRIPTION="Simple Qt archive manager based on libarchive"
HOMEPAGE="https://github.com/tsujan/Arqiver.git"
SNAPSHOT=a17e09aac712162be8b953182f5d69fb1fc740b9
SRC_URI="https://github.com/tsujan/Arqiver/archive/${SNAPSHOT}.tar.gz -> Arqiver-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Arqiver-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

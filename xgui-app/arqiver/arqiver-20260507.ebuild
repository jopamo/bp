# Distributed under the terms of the GNU General Public License v2

inherit cmake xdg

DESCRIPTION="Simple Qt archive manager based on libarchive"
HOMEPAGE="https://github.com/tsujan/Arqiver.git"
SNAPSHOT=446ca1d28238f0881800fa890d67f74c267b21a8
SRC_URI="https://github.com/tsujan/Arqiver/archive/${SNAPSHOT}.tar.gz -> Arqiver-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Arqiver-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

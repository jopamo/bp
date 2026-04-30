# Distributed under the terms of the GNU General Public License v2

inherit cmake xdg

DESCRIPTION="Simple Qt archive manager based on libarchive"
HOMEPAGE="https://github.com/tsujan/Arqiver.git"
SNAPSHOT=6c7a82a210e219ab653b8bbd2a785cb0ba387a26
SRC_URI="https://github.com/tsujan/Arqiver/archive/${SNAPSHOT}.tar.gz -> Arqiver-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Arqiver-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

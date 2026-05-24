# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release-$(ver_cut 1-2).x"

inherit cmake flag-o-matic

DESCRIPTION="Simple DirectMedia Layer"
HOMEPAGE="https://libsdl.org/"
SNAPSHOT=10a82990ee72cd0c1c9bd2d0dbbde0d9d4ee5814
SRC_URI="https://github.com/libsdl-org/SDL/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SDL-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 arm64"

DEPEND="xgui-tools/mesa"

append-flags -ffat-lto-objects

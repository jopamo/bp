# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release-$(ver_cut 1-2).x"

inherit cmake flag-o-matic

DESCRIPTION="Simple DirectMedia Layer"
HOMEPAGE="https://libsdl.org/"
SNAPSHOT=eac186a84c693d246f6d1eeed51c73dfd3fa7f30
SRC_URI="https://github.com/libsdl-org/SDL/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SDL-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 arm64"

DEPEND="xgui-tools/mesa"

PATCHES=( "${FILESDIR}/libsdl3-resolve-library-symlinks.patch" )

append-flags -ffat-lto-objects

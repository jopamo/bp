# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Simple DirectMedia Layer"
HOMEPAGE="https://libsdl.org/"

SNAPSHOT=add4f8c517d7b0275a6dcd67638d073be051ea88
SRC_URI="https://github.com/sabdul-khabir/SDL3_gfx/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/SDL3_gfx-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 arm64"

DEPEND="xmedia-lib/libsdl3"

append-flags -ffat-lto-objects
filter-flags -Wl,-z,defs

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org bitmaps data"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=35307f27a4554f47534fe235be12128157888a7b
SRC_URI="https://gitlab.freedesktop.org/xorg/data/bitmaps/-/archive/${SNAPSHOT}/bitmaps-${SNAPSHOT}.tar.bz2 -> bitmaps-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/bitmaps-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

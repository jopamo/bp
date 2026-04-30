# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X.Org bitmaps data"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=433634f36f791c2779af974ab444c4b521b4a4d8
SRC_URI="https://gitlab.freedesktop.org/xorg/data/bitmaps/-/archive/${SNAPSHOT}/bitmaps-${SNAPSHOT}.tar.bz2 -> bitmaps-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/bitmaps-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

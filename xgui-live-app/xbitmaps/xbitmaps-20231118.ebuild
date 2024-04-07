# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org bitmaps data"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=f11467df3c9e54469fb629762dc3bc35baa563aa
SRC_URI="https://gitlab.freedesktop.org/xorg/data/bitmaps/-/archive/${SNAPSHOT}/bitmaps-${SNAPSHOT}.tar.bz2 -> bitmaps-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/bitmaps-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

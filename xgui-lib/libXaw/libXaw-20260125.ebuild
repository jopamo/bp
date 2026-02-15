# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xaw library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=5f13a7afb2c44ca0997c1394d0e8b0b37ef49148
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXaw/-/archive/${SNAPSHOT}/libXaw-${SNAPSHOT}.tar.bz2 -> libXaw-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxaw-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/libXpm"

src_prepare() {
	eautoreconf
	default
}

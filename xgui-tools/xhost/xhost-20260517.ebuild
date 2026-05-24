# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X server access control utility"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=e37840aa286cf09891798627366d94970118950c
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xhost/-/archive/${SNAPSHOT}/xhost-${SNAPSHOT}.tar.bz2 -> xhost-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xhost-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/libXmu
	xgui-lib/libX11
"

src_prepare() {
	eautoreconf
	default
}

# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X server access control utility"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=101ebe8754637443b0fde22886c4962f638c0fe6
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

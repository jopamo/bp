# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X server access control utility"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=1bf855ea7819c80f6cacacdedfac99c1a0c067ba
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

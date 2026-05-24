# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="property displayer for X"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=d727da3ea929a9bb6d5c3677019e34ba79258ff0
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xprop/-/archive/${SNAPSHOT}/xprop-${SNAPSHOT}.tar.bz2 -> xprop-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xprop-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/libX11
	xgui-tools/xorgproto
"

src_prepare() {
	default
	eautoreconf
}

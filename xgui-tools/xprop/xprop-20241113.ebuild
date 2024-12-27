# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="property displayer for X"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=a6906a8a067bbfaf2f4a47af1521a85340461714
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

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="uncompile an rgb color-name database"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=b1a7317da58136686983c1a50e7f7d3a731dde02
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

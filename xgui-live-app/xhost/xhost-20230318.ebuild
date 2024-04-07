# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="uncompile an rgb color-name database"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=d768e28a42b9187a2007361d6de263303f60bd4e
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xhost/-/archive/${SNAPSHOT}/xhost-${SNAPSHOT}.tar.bz2 -> xhost-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xhost-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-lib/libXmu
	xgui-live-lib/libX11
"

src_prepare() {
	eautoreconf
	default
}

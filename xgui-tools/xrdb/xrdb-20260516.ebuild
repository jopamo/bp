# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X server resource database utility"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=aae4365610d2f3bdd04d30fe303bb936b015ddc4
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xrdb/-/archive/${SNAPSHOT}/xrdb-${SNAPSHOT}.tar.bz2 -> xrdb-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xrdb-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xgui-lib/libXmu
	xgui-lib/libX11"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

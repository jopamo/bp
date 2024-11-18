# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X server resource database utility"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=ff688ceacaddb8e2f345caadfe33e408d97782a0
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

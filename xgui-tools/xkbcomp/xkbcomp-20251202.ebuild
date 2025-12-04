# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="compile XKB keyboard description"
HOMEPAGE="https://www.x.org"
SNAPSHOT=2c7789785981ad1fce3858c726615b49293f7de0
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xkbcomp/-/archive/${SNAPSHOT}/xkbcomp-${SNAPSHOT}.tar.bz2 -> xkbcomp-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xkbcomp-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-lib/libX11
	xgui-lib/libxkbfile
"
BDEPEND="app-build/bison"

src_prepare() {
	default
  eautoreconf
}

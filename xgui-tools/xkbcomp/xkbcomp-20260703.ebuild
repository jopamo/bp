# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="compile XKB keyboard description"
HOMEPAGE="https://www.x.org"
SNAPSHOT=4e36eaa6b6530c195a0c59f0bbab86aa8512c26e
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

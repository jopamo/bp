# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="compile XKB keyboard description"
HOMEPAGE="https://www.x.org"

SNAPSHOT=8e73169bf69f1dd301dbc2bdee68870b3379d949
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

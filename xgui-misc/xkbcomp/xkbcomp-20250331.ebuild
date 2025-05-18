# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="compile XKB keyboard description"
HOMEPAGE="https://www.x.org"

SNAPSHOT=38724ab9f0f013a7d684e5a410f72618603e29cc
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xkbcomp/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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

# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="compile XKB keyboard description"
HOMEPAGE="https://www.x.org"
SNAPSHOT=6ec3b544d6f2c32339062db3933c87c82ac2d2b2
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

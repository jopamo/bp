# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="X.Org xkbfile library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=6289ef997918cafdaae5ddc17a7442e30dede994
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxkbfile/-/archive/${SNAPSHOT}/libxkbfile-${SNAPSHOT}.tar.bz2 -> libxkbfile-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxkbfile-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/libX11
	xgui-tools/xorgproto
"

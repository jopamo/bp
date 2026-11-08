# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="X.Org xkbfile library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=8c2de01b7fc1ad98067e60a6cd9311c96f5195bb
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxkbfile/-/archive/${SNAPSHOT}/libxkbfile-${SNAPSHOT}.tar.bz2 -> libxkbfile-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxkbfile-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/libX11
	xgui-tools/xorgproto
"

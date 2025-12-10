# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X.Org xkbfile library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=cb177c4d0e6d24dd868d28d4c35f3af007e7023e
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxkbfile/-/archive/${SNAPSHOT}/libxkbfile-${SNAPSHOT}.tar.bz2 -> libxkbfile-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxkbfile-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/libX11
	xgui-tools/xorgproto
"

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="primitive command line interface to RandR extension"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=9362e430f59b9fb47129122fa3a5db687819d74d
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xrandr/-/archive/${SNAPSHOT}/xrandr-${SNAPSHOT}.tar.bz2 -> xrandr-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xrandr-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=xgui-lib/libXrandr-1.5
	xgui-lib/libXrender
	xgui-lib/libX11"

src_prepare() {
	default
	eautoreconf
}

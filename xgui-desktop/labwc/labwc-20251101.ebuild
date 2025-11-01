# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland window-stacking compositor"
HOMEPAGE="https://github.com/labwc/labwc"
SNAPSHOT=ef01ebe18747fd28ce0184164762a0d3d13acf0c
SRC_URI="https://github.com/labwc/labwc/archive/${SNAPSHOT}.tar.gz -> labwc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/labwc-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/wlroots
"

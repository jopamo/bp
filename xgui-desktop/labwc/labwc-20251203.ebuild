# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland window-stacking compositor"
HOMEPAGE="https://github.com/labwc/labwc"
SNAPSHOT=06505d24c8d3a5e5fa1d0212789aa104ff97b8ed
SRC_URI="https://github.com/labwc/labwc/archive/${SNAPSHOT}.tar.gz -> labwc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/labwc-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/wlroots
"

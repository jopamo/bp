# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland window-stacking compositor"
HOMEPAGE="https://github.com/labwc/labwc"
SNAPSHOT=db7c72ef39ebb5f575e1956a73b68f2a40b0f2e2
SRC_URI="https://github.com/labwc/labwc/archive/${SNAPSHOT}.tar.gz -> labwc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/labwc-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/wlroots
"

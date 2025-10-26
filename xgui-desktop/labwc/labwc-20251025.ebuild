# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland window-stacking compositor"
HOMEPAGE="https://github.com/labwc/labwc"
SNAPSHOT=cd1a823fee6fc44e1e892ff0192a4710a5a07ba2
SRC_URI="https://github.com/labwc/labwc/archive/${SNAPSHOT}.tar.gz -> labwc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/labwc-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/wlroots
"

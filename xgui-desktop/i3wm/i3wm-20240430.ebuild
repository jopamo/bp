# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A tiling window manager"
HOMEPAGE="https://swaywm.org"

SNAPSHOT=d54a10b200e6e14b36c0fb618525c2cfe434e4fa
SRC_URI="https://github.com/i3/i3/archive/${SNAPSHOT}.tar.gz -> i3-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/i3-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-misc/startup-notification
	xgui-tools/xcb-util-xrm
	xgui-lib/yajl
"

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A tiling window manager"
HOMEPAGE="https://swaywm.org"
SNAPSHOT=5c321cc5822e4d3aa0dc1386b60d9aecd4c48b8f
SRC_URI="https://github.com/i3/i3/archive/${SNAPSHOT}.tar.gz -> i3-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/i3-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-tools/startup-notification
	xgui-tools/xcb-util-xrm
	xgui-lib/yajl
"

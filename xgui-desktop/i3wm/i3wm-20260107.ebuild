# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A tiling window manager"
HOMEPAGE="https://i3wm.org/"
SNAPSHOT=57f628629f0b2a3f6fa16dbbe94ae2ed044090d6
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

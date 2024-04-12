# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A tiling window manager"
HOMEPAGE="https://swaywm.org"

SNAPSHOT=051d3537e3e028c55572658cf154a82b11248d91
SRC_URI="https://github.com/i3/i3/archive/${SNAPSHOT}.tar.gz -> i3-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/i3-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-app/startup-notification
	xgui-live-app/xcb-util-xrm
	xgui-live-lib/yajl
"

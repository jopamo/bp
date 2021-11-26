# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A tiling window manager"
HOMEPAGE="https://swaywm.org"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/i3/i3.git"
	inherit git-r3
else
	SRC_URI="https://github.com/i3/i3/releases/download/${PV}/${P}.tar.gz"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-app/startup-notification
	xgui-live-app/xcb-util-xrm
	xgui-live-lib/yajl
"

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A tiling window manager"
HOMEPAGE="https://swaywm.org"

SNAPSHOT=47cab33aa8b3c8b47e34de6148440a1bc30a2297
SRC_URI="https://github.com/i3/i3/archive/${SNAPSHOT}.tar.gz -> i3-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/i3-${SNAPSHOT}"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/i3/i3"
	inherit
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

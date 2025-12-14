# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://github.com/flameshot-org/flameshot"

SNAPSHOT=76f8067b2d69f847a1d858b9e4e16dbf402c8c13
SRC_URI="https://github.com/flameshot-org/flameshot/archive/${SNAPSHOT}.tar.gz -> flameshot-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/flameshot-${SNAPSHOT}"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland"

DEPEND="
	xgui-lib/qtsvg:5
	xgui-lib/qtbase:5
	xmedia-app/singleapplication
"

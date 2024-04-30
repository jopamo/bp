# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://github.com/flameshot-org/flameshot"

SNAPSHOT=e63aea6722b478cd61fe4ec4fadc90612eafa75a
SRC_URI="https://github.com/flameshot-org/flameshot/archive/${SNAPSHOT}.tar.gz -> flameshot-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/flameshot-${SNAPSHOT}"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

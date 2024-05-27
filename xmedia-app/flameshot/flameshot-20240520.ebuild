# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://github.com/flameshot-org/flameshot"

SNAPSHOT=a1dda59108d420a26d603a40d1c7d25e4114d748
SRC_URI="https://github.com/flameshot-org/flameshot/archive/${SNAPSHOT}.tar.gz -> flameshot-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/flameshot-${SNAPSHOT}"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

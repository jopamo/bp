# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A style to bend Qt applications to look like they belong into GNOME Shell"
HOMEPAGE="https://github.com/FedoraQt/adwaita-qt"

SNAPSHOT=0a774368916def5c9889de50f3323dec11de781e
SRC_URI="https://github.com/FedoraQt/adwaita-qt/archive/${SNAPSHOT}.tar.gz -> adwaita-qt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/adwaita-qt-${SNAPSHOT}"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Openbox window manager configuration tool"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=37341702344c54e9c53ef59eca453fd2ffd64f80
SRC_URI="https://www.github.com/lxqt/obconf-qt/archive/${SNAPSHOT}.tar.gz -> obconf-qt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/obconf-qt-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-desktop/openbox
	xgui-lib/qtbase
"

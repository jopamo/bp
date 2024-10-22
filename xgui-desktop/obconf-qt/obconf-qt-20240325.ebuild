# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Openbox window manager configuration tool"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=d2626ef4d36f312048c8968cc175599a21c8f1cb
SRC_URI="https://www.github.com/lxqt/obconf-qt/archive/${SNAPSHOT}.tar.gz -> obconf-qt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/obconf-qt-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

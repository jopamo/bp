# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="The module contains unsupported Qt 5 APIs"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=6ae9cd9d13ff5ae3d254c79918f0637103da14c2
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	>=xgui-lib/qtshadertools-6.12:6=
	>=xgui-lib/qtbase-6.12:6=
"

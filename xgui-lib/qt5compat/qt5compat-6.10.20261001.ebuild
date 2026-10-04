# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="The module contains unsupported Qt 5 APIs"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=d0082c10516058d42a41b9b8c15ff394c45ed15f
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtshadertools
	xgui-lib/qtbase:$(ver_cut 1)=
"

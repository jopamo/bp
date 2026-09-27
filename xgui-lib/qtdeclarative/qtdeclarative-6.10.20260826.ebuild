# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake flag-o-matic

DESCRIPTION="Qt QML and Qt Quick modules for the Qt 6 framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=cb44be928d5b30da569f48742dc3f2041c736e15
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase:$(ver_cut 1)
	xgui-lib/qtshadertools:$(ver_cut 1)
"

append-flags -ffat-lto-objects

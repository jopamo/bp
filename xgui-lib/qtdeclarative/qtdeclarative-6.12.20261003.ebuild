# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake flag-o-matic

DESCRIPTION="Qt QML and Qt Quick modules for the Qt 6 framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=112f58eb2ebbfc4d8d6d36063b2081519d997487
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	>=xgui-lib/qtbase-6.12:6=
	>=xgui-lib/qtshadertools-6.12:6=
"

append-flags -ffat-lto-objects

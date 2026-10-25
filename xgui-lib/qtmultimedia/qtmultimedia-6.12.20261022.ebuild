# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="Qt 6 multimedia framework for audio, video, radio, and camera"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=98f7ae47eb4837b14528532a9148a4d30e19eb04
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	>=xgui-lib/qtbase-6.12:6=
	>=xgui-lib/qtshadertools-6.12:6=
"

# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="Qt 6 multimedia framework for audio, video, radio, and camera"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=e61e06d9a333cd7909cebc7d35408df4eba45828
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase:$(ver_cut 1)=
	xgui-lib/qtshadertools:$(ver_cut 1)=
"

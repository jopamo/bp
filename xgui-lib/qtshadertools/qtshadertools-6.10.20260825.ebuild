# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="Shader tools module for the Qt framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=6a1ee4da02d5db00bfd4d19bcfa5a2e4ff7494a2
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase:$(ver_cut 1)=
"

# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="kde/$(ver_cut 1-2)"

inherit qmake-utils

DESCRIPTION="Linux/X11-specific support library for the Qt5 framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=c44c4fa86fa0794c25baef4ee1f6272aca8c511a
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase:$(ver_cut 1)"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="Qt5 module for integrating online documentation into applications"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=
SRC_URI="https://github.com/qt/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)/1"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	cleanup_install
}

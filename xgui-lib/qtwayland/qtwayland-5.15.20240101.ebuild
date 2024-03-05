# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qmake-utils

DESCRIPTION="Wayland platform plugin for Qt"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=c8b37a1bda9b8f29d56775ed6556d56ac5d3ea1d
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}

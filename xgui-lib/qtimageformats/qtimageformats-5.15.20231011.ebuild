# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qmake-utils

DESCRIPTION="Additional format plugins for the Qt image I/O system"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=1019058c497e33edef80d5cb120aa7d6a418a7c6
SRC_URI="https://github.com/qt/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
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

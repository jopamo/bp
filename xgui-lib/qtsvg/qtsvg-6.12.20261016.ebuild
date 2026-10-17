# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake flag-o-matic

DESCRIPTION="SVG image format support module for Qt 6"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=2457301e467161a1dad2cca1aae1d8ae0ea97c67
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND=">=xgui-lib/qtbase-6.12:6="

append-flags -ffat-lto-objects

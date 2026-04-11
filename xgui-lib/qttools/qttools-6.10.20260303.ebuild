# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake flag-o-matic

DESCRIPTION="Qt Tools collection (Assistant, Designer, Linguist, etc.)"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=4b1a5798e42d9ca737cda924cceddd9db0cf1e01
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase:$(ver_cut 1)
	xgui-lib/qtdeclarative:$(ver_cut 1)
	"

append-flags -ffat-lto-objects

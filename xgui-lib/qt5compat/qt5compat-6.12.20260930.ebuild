# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake

DESCRIPTION="The module contains unsupported Qt 5 APIs"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=6db888763bca84c57c89ea2784113001a9c19d9a
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	>=xgui-lib/qtshadertools-6.12:6=
	>=xgui-lib/qtbase-6.12:6=
"

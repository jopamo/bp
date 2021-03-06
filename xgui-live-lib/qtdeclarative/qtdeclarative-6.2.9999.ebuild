# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="The QML and Quick modules for the Qt5 framework"
HOMEPAGE="https://www.qt.io/"
EGIT_REPO_URI="https://github.com/qt/${PN}.git"
EGIT_BRANCH=$(ver_cut 1).$(ver_cut 2)

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="xgui-live-lib/qtbase"

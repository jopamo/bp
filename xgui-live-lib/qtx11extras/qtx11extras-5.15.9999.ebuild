# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils

DESCRIPTION="Linux/X11-specific support library for the Qt5 framework"
HOMEPAGE="https://www.qt.io/"
EGIT_REPO_URI="https://code.qt.io/qt/${PN}.git"
EGIT_BRANCH=$(ver_cut 1).$(ver_cut 2)

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)/1"
KEYWORDS="amd64 arm64"

DEPEND="xgui-live-lib/qtbase"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}

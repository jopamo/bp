# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="Linux/X11-specific support library for the Qt5 framework"
HOMEPAGE="https://www.qt.io/"

if [[ ${PV} == *9999 ]]; then
	EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"
	EGIT_REPO_URI="https://github.com/qt/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=610c94f80802f67b59c00cac1f229e3d13b8de35
	SRC_URI="https://github.com/qt/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}

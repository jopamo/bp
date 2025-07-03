# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The QML and Quick modules for the Qt5 framework"
HOMEPAGE="https://www.qt.io/"

if [[ ${PV} == *9999 ]]; then
	EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"
	EGIT_REPO_URI="https://github.com/qt/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=a43df98d037ad07cf096ef2f775958ceba743613
	SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase:$(ver_cut 1)"

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Lightweight Qt image viewer from the LXQt Project"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=e2b8fa0e00204d5b24fffa7a813ef727f90ee464
SRC_URI="https://github.com/lxqt/lximage-qt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/lximage-qt-${SNAPSHOT}

LICENSE="|| ( GPL-2+ LGPL-2.1+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-dev/lxqt-build-tools"
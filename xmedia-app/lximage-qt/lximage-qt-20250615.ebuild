# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Lightweight Qt image viewer from the LXQt Project"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=7d7ed30c9d741104eef09c1716575f5ab699b962
SRC_URI="https://github.com/lxqt/lximage-qt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lximage-qt-${SNAPSHOT}

LICENSE="|| ( GPL-2+ LGPL-2.1+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-dev/lxqt-build-tools"
DEPEND="
	xgui-lib/libfm-qt
"

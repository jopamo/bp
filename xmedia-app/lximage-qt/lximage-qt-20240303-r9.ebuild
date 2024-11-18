# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Lightweight Qt image viewer from the LXQt Project"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=48de1ba52d6f543126d87f0dd4643da08e238966
SRC_URI="https://github.com/lxqt/lximage-qt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/lximage-qt-${SNAPSHOT}

LICENSE="|| ( GPL-2+ LGPL-2.1+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-dev/lxqt-build-tools"
DEPEND="
	xgui-lib/libfm-qt
"

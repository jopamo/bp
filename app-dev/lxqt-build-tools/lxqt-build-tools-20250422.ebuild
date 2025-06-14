# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt Build tools"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=29553ec4507e7f3aa8f0e16f26fe029efe66c6ae
SRC_URI="https://github.com/lxqt/lxqt-build-tools/archive/${SNAPSHOT}.tar.gz -> lxqt-build-tools-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lxqt-build-tools-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

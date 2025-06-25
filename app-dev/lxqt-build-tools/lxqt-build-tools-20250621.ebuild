# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt Build tools"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=7d976627b177c2eb4c249f0c372949575ce751bd
SRC_URI="https://github.com/lxqt/lxqt-build-tools/archive/${SNAPSHOT}.tar.gz -> lxqt-build-tools-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lxqt-build-tools-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

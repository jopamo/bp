# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt Build tools"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=1304079edbe62c8c9e528de8ee0cf1a1119724dc
SRC_URI="https://github.com/lxqt/lxqt-build-tools/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

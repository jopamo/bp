# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt Build tools"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=91db61db0a321678824724234ac060cc8551e865
SRC_URI="https://github.com/lxqt/lxqt-build-tools/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

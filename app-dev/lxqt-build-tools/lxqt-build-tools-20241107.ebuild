# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt Build tools"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=ae11af1975ffc33d107e3ba4b675ee39b677b209
SRC_URI="https://github.com/lxqt/lxqt-build-tools/archive/${SNAPSHOT}.tar.gz -> lxqt-build-tools-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

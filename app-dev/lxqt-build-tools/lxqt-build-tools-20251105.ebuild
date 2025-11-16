# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt Build tools"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=1708c068b3e03f06215c0e2a9423e0a9d7cf6589
SRC_URI="https://github.com/lxqt/lxqt-build-tools/archive/${SNAPSHOT}.tar.gz -> lxqt-build-tools-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lxqt-build-tools-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

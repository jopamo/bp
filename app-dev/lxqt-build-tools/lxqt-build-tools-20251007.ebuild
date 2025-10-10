# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt Build tools"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=a4999045187808bb899ede4d5c4941782ba111c1
SRC_URI="https://github.com/lxqt/lxqt-build-tools/archive/${SNAPSHOT}.tar.gz -> lxqt-build-tools-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lxqt-build-tools-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase"

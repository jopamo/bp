# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt configuration center and tools for editing desktop settings"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=0c5aa651e4d6386f78a716042eb2e506b6f5b0b3
SRC_URI="https://github.com/lxqt/lxqt-config/archive/${SNAPSHOT}.tar.gz -> lxqt-config-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-config-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"

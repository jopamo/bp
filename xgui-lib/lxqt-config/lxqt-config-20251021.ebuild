# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt configuration center and tools for editing desktop settings"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=4a1c6d4112b4a55707cb9c539e1a3b2e777faea1
SRC_URI="https://github.com/lxqt/lxqt-config/archive/${SNAPSHOT}.tar.gz -> lxqt-config-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-config-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"

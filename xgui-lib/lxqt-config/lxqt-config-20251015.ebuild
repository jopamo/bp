# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Daemon used to register global keyboard shortcuts"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=d81906c00a583d501113ec9787b5438374e0b0e6
SRC_URI="https://github.com/lxqt/lxqt-config/archive/${SNAPSHOT}.tar.gz -> lxqt-config-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-config-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"

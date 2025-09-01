# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Daemon used to register global keyboard shortcuts"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=421b87ec067a6158a962098e1ba176855568e47c
SRC_URI="https://github.com/lxqt/lxqt-config/archive/${SNAPSHOT}.tar.gz -> lxqt-config-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-config-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"

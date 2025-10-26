# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Qt implementation of the DBusMenu protocol"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=ee669ce9914fbc31c8936afee80b4230756870c2
SRC_URI="https://github.com/lxqt/libdbusmenu-lxqt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"

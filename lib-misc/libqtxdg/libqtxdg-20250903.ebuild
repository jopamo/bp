# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="https://lxqt.org/"
SNAPSHOT=320f05e324ed27ac5442be189862dc4f81b80235
SRC_URI="https://github.com/lxqt/libqtxdg/archive/${SNAPSHOT}.tar.gz -> libqtxdg-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libqtxdg-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase
		app-dev/lxqt-build-tools"
RDEPEND="xgui-lib/xdg-utils"
BDEPEND="app-dev/pkgconf"

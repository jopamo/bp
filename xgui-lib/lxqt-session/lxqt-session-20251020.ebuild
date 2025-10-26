# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt session manager (startup, logout, autostart handling)"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=472cb74b26230878dc0e3d4026a00fac69c44ea9
SRC_URI="https://github.com/lxqt/lxqt-session/archive/${SNAPSHOT}.tar.gz -> lxqt-session-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-session-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"
DEPEND="
	xgui-lib/xdg-user-dirs
	xgui-lib/qtxdg-tools"

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt session manager (startup, logout, autostart handling)"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=572c4dfd8834b3f162f4e9a4855bb5eee8a3b595
SRC_URI="https://github.com/lxqt/lxqt-session/archive/${SNAPSHOT}.tar.gz -> lxqt-session-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-session-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"
DEPEND="
	xgui-lib/xdg-user-dirs
	xgui-lib/qtxdg-tools"

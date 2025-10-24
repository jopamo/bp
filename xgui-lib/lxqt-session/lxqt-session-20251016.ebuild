# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LXQt session manager (startup, logout, autostart handling)"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=02f6dcc0c2828e80806804b1a8e46e89d5c2d24a
SRC_URI="https://github.com/lxqt/lxqt-session/archive/${SNAPSHOT}.tar.gz -> lxqt-session-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-session-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"
DEPEND="
	xgui-lib/xdg-user-dirs
	xgui-lib/qtxdg-tools"

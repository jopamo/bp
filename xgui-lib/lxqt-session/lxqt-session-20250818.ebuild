# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Daemon used to register global keyboard shortcuts"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=cfcea960d02b33e7d7a86b47020620427d83d924
SRC_URI="https://github.com/lxqt/lxqt-session/archive/${SNAPSHOT}.tar.gz -> lxqt-session-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-session-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"
DEPEND="
	xgui-lib/xdg-user-dirs
	xgui-lib/qtxdg-tools"

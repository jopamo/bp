# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Menu metadata and categories used by LXQt application menus"
HOMEPAGE="http://lxde.org/"
SNAPSHOT=2b326504466b5be5c281a1dd9d29c38e93b215d7
SRC_URI="https://github.com/lxqt/lxqt-menu-data/archive/${SNAPSHOT}.tar.gz -> lxqt-menu-data-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-menu-data-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-build/gettext
	app-dev/intltool
	app-dev/pkgconf
	lib-util/glib
	app-dev/lxqt-build-tools
"

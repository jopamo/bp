# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Provides files needed for LXDE application menus"
HOMEPAGE="http://lxde.org/"

SNAPSHOT=22fa7ff1190b001ca1903231dd311564b071c97b
SRC_URI="https://github.com/lxqt/lxqt-menu-data/archive/${SNAPSHOT}.tar.gz -> lxqt-menu-data-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-menu-data-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-build/gettext
	app-dev/intltool
	app-dev/pkgconf
	lib-live/glib
"

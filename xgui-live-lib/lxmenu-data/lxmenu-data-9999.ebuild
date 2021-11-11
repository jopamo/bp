# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Provides files needed for LXDE application menus"
HOMEPAGE="http://lxde.org/"
EGIT_REPO_URI="https://github.com/lxde/lxmenu-data.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-build/gettext
	app-dev/intltool
	app-dev/pkgconf
	lib-live/glib
"

src_prepare() {
	default
	eautoreconf
}

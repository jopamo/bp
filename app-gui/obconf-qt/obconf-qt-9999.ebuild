# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Openbox window manager configuration tool"
HOMEPAGE="http://lxqt.org/"
EGIT_REPO_URI="https://www.github.com/lxqt/${PN}.git"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/glib:2
	lib-core/libxml2
	lib-gui/qtbase
	lib-gui/qtx11extras:5
	lib-media/fontconfig
	lib-media/freetype
	app-gui/openbox
	x11-live-libs/libICE
	x11-live-libs/libSM
	x11-live-libs/libX11
	x11-live-libs/libXft
	x11-live-libs/pango
"

BDEPEND="dev-util/pkgconf"

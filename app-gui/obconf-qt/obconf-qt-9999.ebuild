# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Openbox window manager configuration tool"
HOMEPAGE="http://lxqt.org/"
EGIT_REPO_URI="https://www.github.com/lxqt/${PN}.git"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0/1"
KEYWORDS="amd64 arm64"

RDEPEND="lib-dev/glib:2
	lib-dev/libxml2
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	lib-media/fontconfig
	lib-media/freetype
	x11-app/openbox
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/pango
"
DEPEND="${RDEPEND}
	gui-lib/linguist-tools:5
	dev-util/pkgconf"

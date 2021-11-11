# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Openbox window manager configuration tool"
HOMEPAGE="http://lxqt.org/"
EGIT_REPO_URI="https://www.github.com/lxqt/${PN}.git"

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-live/glib
	lib-core/libxml2
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras:5
	fonts/fontconfig
	xgui-misc/freetype
	xgui-live-app/openbox
	xgui-live-lib/libICE
	xgui-live-lib/libSM
	xgui-live-lib/libX11
	xgui-live-lib/libXft
	xgui-live-lib/pango
"

BDEPEND="app-dev/pkgconf"

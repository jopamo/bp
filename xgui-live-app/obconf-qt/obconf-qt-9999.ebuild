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
	lib-live/glib:2
	lib-core/libxml2
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras:5
	xmedia-live-lib/fontconfig
	xmedia-live-lib/freetype
	xgui-live-app/openbox
	x11-live-lib/libICE
	x11-live-lib/libSM
	x11-live-lib/libX11
	x11-live-lib/libXft
	x11-live-lib/pango
"

BDEPEND="dev-util/pkgconf"

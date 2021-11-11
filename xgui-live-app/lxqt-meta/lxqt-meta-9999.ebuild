# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta ebuild for LXQt, the Lightweight Desktop Environment"
HOMEPAGE="https://lxqt.github.io/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	fonts/liberation-fonts
	app-fs/ncdu
	xgui-icontheme/dracula-theme
	xgui-live-app/arqiver
	xgui-live-app/featherpad
	xgui-live-app/lxappearance
	xgui-live-app/lxqt-panel
	xgui-live-app/lxterminal
	xgui-live-app/obconf-qt
	xgui-live-app/openbox
	xgui-live-app/pcmanfm
	xgui-live-app/speedcrunch
	xgui-live-app/xrandr
	xmedia-live-app/lximage-qt
"

# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta ebuild for LXQt, the Lightweight Desktop Environment"
HOMEPAGE="https://lxqt.github.io/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	fonts/liberation-fonts
	sys-fs/ncdu
	xgui-icontheme/dracula-theme
	xgui-icontheme/hicolor-icon-theme
	xgui-icontheme/oxygen-icon-theme
	xgui-icontheme/papirus-icon-theme
	xgui-live-app/arqiver
	xgui-live-app/featherpad
	xgui-live-app/lxappearance
	xgui-live-app/lxqt-config
	xgui-live-app/lxqt-panel
	xgui-live-app/lxterminal
	xgui-live-app/obconf-qt
	xgui-live-app/openbox
	xgui-live-app/pcmanfm
	xgui-live-app/speedcrunch
	xgui-live-app/xrandr
	xgui-live-lib/lxmenu-data
	xgui-live-lib/lxqt-globalkeys
	xgui-live-lib/lxqt-themes
	xmedia-live-app/lximage-qt
"

# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta ebuild for LXQt, the Lightweight Desktop Environment"
HOMEPAGE="https://lxqt.github.io/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	xgui-icontheme/hicolor-icon-theme
	xgui-icontheme/oxygen-icon-theme
	xgui-live-lib/lxmenu-data
	=xgui-live-app/lxqt-config-${PV}*
	=xgui-live-lib/lxqt-globalkeys-${PV}*
	=xgui-live-app/lxqt-panel-${PV}*
	fonts/liberation-fonts
	=xgui-live-lib/lxqt-themes-${PV}*
	xgui-live-app/arqiver
	xgui-live-app/pcmanfm-qt
	xmedia-live-app/lximage-qt
	xgui-live-app/openbox
	xgui-live-app/obconf-qt
	xgui-live-app/qterminal
	xgui-live-app/featherpad
	xgui-live-app/speedcrunch
"

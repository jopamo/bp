# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="LXQt desktop panel and plugins"
HOMEPAGE="http://lxqt.org/"
KEYWORDS="amd64 arm64"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="https://github.com/lxde/${PN}/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="+alsa +clock colorpicker cpuload +desktopswitch dom +kbindicator +mainmenu
	networkmonitor pulseaudio +quicklaunch sensors +showdesktop
	statusnotifier sysstat +taskbar +tray +volume"
REQUIRED_USE="volume? ( || ( alsa pulseaudio ) )"

CDEPEND="
	lib-dev/glib:2
	>=lib-dev/libqtxdg-3.1.0
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	gui-lib/qtxml:5
	x11/kguiaddons
	x11/kwindowsystem
	>=gui-lib/menu-cache-0.3.3
	gui-lib/liblxqt
	gui-lib/lxqt-globalkeys
	x11-libs/libX11
	cpuload? ( lib-sys/libstatgrab )
	kbindicator? ( x11-libs/libxkbcommon )
	networkmonitor? ( lib-sys/libstatgrab )
	sensors? ( sys-app/lm_sensors )
	statusnotifier? ( >=lib-dev/libdbusmenu-qt-0.9.3_pre20160218-r1 )
	sysstat? ( =gui-lib/libsysstat-0.3* )
	tray? ( x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXrender )
"
DEPEND="${CDEPEND}
	gui-lib/linguist-tools:5
	>=dev-util/lxqt-build-tools-0.3.1
"
RDEPEND="${CDEPEND}
	gui-lib/qtsvg:5
	>=gui-lib/lxmenu-data-0.1.2
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_configure() {
	local mycmakeargs=(
		$(usex clock '-DWORLDCLOCK_PLUGIN=ON' '-DWORLDCLOCK_PLUGIN=OFF')
		$(usex colorpicker '-DCOLORPICKER_PLUGIN=ON' '-DCOLORPICKER_PLUGIN=OFF')
		$(usex cpuload '-DCPULOAD_PLUGIN=ON' '-DCPULOAD_PLUGIN=OFF')
		$(usex desktopswitch '-DDESKTOPSWITCH_PLUGIN=ON' '-DDESKTOPSWITCH_PLUGIN=OFF')
		$(usex dom '-DDOM_PLUGIN=ON' '-DDOM_PLUGIN=OFF')
		$(usex kbindicator '-DKBINDICATOR_PLUGIN=ON' '-DKBINDICATOR_PLUGIN=OFF')
		$(usex mainmenu '-DMAINMENU_PLUGIN=ON' '-DMAINMENU_PLUGIN=OFF')
		$(usex networkmonitor '-DNETWORKMONITOR_PLUGIN=ON' '-DNETWORKMONITOR_PLUGIN=OFF')
		$(usex quicklaunch '-DQUICKLAUNCH_PLUGIN=ON' '-DQUICKLAUNCH_PLUGIN=OFF')
		$(usex sensors '-DSENSORS_PLUGIN=ON' '-DSENSORS_PLUGIN=OFF')
		$(usex showdesktop '-DSHOWDESKTOP_PLUGIN=ON' '-DSHOWDESKTOP_PLUGIN=OFF')
		$(usex statusnotifier '-DSTATUSNOTIFIER_PLUGIN=ON' '-DSTATUSNOTIFIER_PLUGIN=OFF')
		$(usex sysstat '-DSYSSTAT_PLUGIN=ON' '-DSYSSTAT_PLUGIN=OFF')
		$(usex taskbar '-DTASKBAR_PLUGIN=ON' '-DTASKBAR_PLUGIN=OFF')
		$(usex tray '-DTRAY_PLUGIN=ON' '-DTRAY_PLUGIN=OFF')
		-DVOLUME_PLUGIN=OFF
		-DMOUNT_PLUGIN=OFF
	)

	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
	doman panel/man/*.1
}

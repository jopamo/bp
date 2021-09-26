# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="LXQt desktop panel and plugins"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="https://github.com/lxde/${PN}/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa +clock colorpicker cpuload desktopswitch dom kbindicator
	mainmenu networkmonitor pulseaudio quicklaunch sensors showdesktop
	statusnotifier sysstat +taskbar +tray volume"
REQUIRED_USE="volume? ( || ( alsa pulseaudio ) )"

DEPEND="
	lib-live/glib
	lib-live/libqtxdg
	xgui-live-lib/qtbase:5
	xgui-live-app/kguiaddons
	xgui-live-app/kwindowsystem
	xgui-live-lib/menu-cache
	xgui-live-lib/liblxqt
	xgui-live-lib/lxqt-globalkeys
	xgui-live-lib/libX11
	cpuload? ( lib-core/libstatgrab )
	kbindicator? ( xgui-live-lib/libxkbcommon )
	networkmonitor? ( lib-core/libstatgrab )
	sensors? ( app-core/lm_sensors )
	sysstat? ( xgui-live-lib/libsysstat )
	tray? ( xgui-live-lib/libXcomposite
		xgui-live-lib/libXdamage
		xgui-live-lib/libXrender )
"
BDEPEND="dev-util/lxqt-build-tools"
RDEPEND="
	xgui-icontheme/lxqt-themes
	xgui-live-lib/qtsvg
	xgui-live-lib/lxmenu-data
"

filter-flags -Wl,-z,defs

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
		-DSTATUSNOTIFIER_PLUGIN=OFF
		$(usex sysstat '-DSYSSTAT_PLUGIN=ON' '-DSYSSTAT_PLUGIN=OFF')
		$(usex taskbar '-DTASKBAR_PLUGIN=ON' '-DTASKBAR_PLUGIN=OFF')
		$(usex tray '-DTRAY_PLUGIN=ON' '-DTRAY_PLUGIN=OFF')
		-DVOLUME_PLUGIN=OFF
		-DMOUNT_PLUGIN=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto etc/xdg/lxqt
	doins ${FILESDIR}/{panel.conf,lxqt.conf}
}

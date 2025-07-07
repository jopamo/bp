# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="LXQt desktop panel and plugins"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=2832ba356cc56aa9de65295b454369848ffb2d13
SRC_URI="https://github.com/lxqt/lxqt-panel/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa clock colorpicker cpuload desktopswitch dom kbindicator
	mainmenu networkmonitor pulseaudio quicklaunch sensors showdesktop
	statusnotifier sysstat +taskbar +tray volume"
REQUIRED_USE="volume? ( || ( alsa pulseaudio ) )"

DEPEND="
	lib-util/glib
	lib-misc/libqtxdg
	xgui-tools/kguiaddons
	xgui-tools/kwindowsystem:6
	xgui-lib/libX11
	xgui-lib/liblxqt
	xgui-lib/lxqt-globalkeys
	xgui-lib/qtbase:6
	xgui-misc/menu-cache
	cpuload? ( lib-core/libstatgrab )
	kbindicator? ( xgui-lib/libxkbcommon )
	networkmonitor? ( lib-core/libstatgrab )
	sensors? ( app-core/lm_sensors )
	sysstat? ( xgui-live-lib/libsysstat )
	tray? ( xgui-lib/libXcomposite
		xgui-lib/libXdamage
		xgui-lib/libXrender )
"
BDEPEND="app-dev/lxqt-build-tools"
RDEPEND="
	xgui-icontheme/lxqt-themes
	xgui-lib/qtsvg
	xgui-lib/lxqt-menu-data
"

src_configure() {
	filter-flags -Wl,-z,defs

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

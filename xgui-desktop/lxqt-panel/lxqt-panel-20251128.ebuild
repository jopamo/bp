# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="LXQt desktop panel and plugins"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=0e652cf8160d330600339e85f9d795aa2dc37101
SRC_URI="https://github.com/jopamo/1g4-panel/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/1g4-panel-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="backlight +clock colorpicker cpuload customcommand desktopswitch
	directorymenu dom fancymenu kbindicator mainmenu networkmonitor
	qeyes quicklaunch sensors showdesktop spacer +statusnotifier
	sysstat +taskbar +volume"

DEPEND="
	lib-util/glib
	lib-misc/libqtxdg
	xgui-tools/kguiaddons
	xgui-tools/kwindowsystem:6
	xgui-lib/libX11
	xgui-lib/liblxqt
	xgui-lib/qtbase:6
	xgui-tools/menu-cache
	cpuload? ( lib-core/libstatgrab )
	kbindicator? ( xgui-lib/libxkbcommon )
	networkmonitor? ( lib-core/libstatgrab )
	sensors? ( app-core/lm_sensors )
	statusnotifier? ( xgui-lib/libdbusmenu-lxqt )
	sysstat? ( xgui-live-lib/libsysstat )
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
		# Fallback only makes sense if quicklaunch is built
		-DWITH_SCREENSAVER_FALLBACK=$(usex quicklaunch ON OFF)

		# Plugins present in CMakeLists.txt
		$(usex backlight       '-DBACKLIGHT_PLUGIN=ON'       '-DBACKLIGHT_PLUGIN=OFF')
		$(usex clock           '-DWORLDCLOCK_PLUGIN=ON'      '-DWORLDCLOCK_PLUGIN=OFF')
		$(usex colorpicker     '-DCOLORPICKER_PLUGIN=ON'     '-DCOLORPICKER_PLUGIN=OFF')
		$(usex cpuload         '-DCPULOAD_PLUGIN=ON'         '-DCPULOAD_PLUGIN=OFF')
		$(usex customcommand   '-DCUSTOMCOMMAND_PLUGIN=ON'   '-DCUSTOMCOMMAND_PLUGIN=OFF')
		$(usex desktopswitch   '-DDESKTOPSWITCH_PLUGIN=ON'   '-DDESKTOPSWITCH_PLUGIN=OFF')
		$(usex directorymenu   '-DDIRECTORYMENU_PLUGIN=ON'   '-DDIRECTORYMENU_PLUGIN=OFF')
		$(usex dom             '-DDOM_PLUGIN=ON'             '-DDOM_PLUGIN=OFF')
		$(usex fancymenu       '-DFANCYMENU_PLUGIN=ON'       '-DFANCYMENU_PLUGIN=OFF')
		$(usex kbindicator     '-DKBINDICATOR_PLUGIN=ON'     '-DKBINDICATOR_PLUGIN=OFF')
		$(usex mainmenu        '-DMAINMENU_PLUGIN=ON'        '-DMAINMENU_PLUGIN=OFF')
		$(usex networkmonitor  '-DNETWORKMONITOR_PLUGIN=ON'  '-DNETWORKMONITOR_PLUGIN=OFF')
		$(usex qeyes           '-DQEYES_PLUGIN=ON'           '-DQEYES_PLUGIN=OFF')
		$(usex quicklaunch     '-DQUICKLAUNCH_PLUGIN=ON'     '-DQUICKLAUNCH_PLUGIN=OFF')
		$(usex sensors         '-DSENSORS_PLUGIN=ON'         '-DSENSORS_PLUGIN=OFF')
		$(usex showdesktop     '-DSHOWDESKTOP_PLUGIN=ON'     '-DSHOWDESKTOP_PLUGIN=OFF')
		$(usex spacer          '-DSPACER_PLUGIN=ON'          '-DSPACER_PLUGIN=OFF')
		$(usex statusnotifier  '-DSTATUSNOTIFIER_PLUGIN=ON'  '-DSTATUSNOTIFIER_PLUGIN=OFF')
		$(usex sysstat         '-DSYSSTAT_PLUGIN=ON'         '-DSYSSTAT_PLUGIN=OFF')
		$(usex taskbar         '-DTASKBAR_PLUGIN=ON'         '-DTASKBAR_PLUGIN=OFF')
		$(usex volume          '-DVOLUME_PLUGIN=ON'          '-DVOLUME_PLUGIN=OFF')
	)


	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto etc/xdg/lxqt
	doins ${FILESDIR}/{panel.conf,lxqt.conf}
}

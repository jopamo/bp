# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="a panel"
HOMEPAGE="https://github.com/jopamo/1g4-panel"

SNAPSHOT=4c1c845def0893895f40d77a1bab2b913fedd0a9
SRC_URI="https://github.com/jopamo/1g4-panel/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/1g4-panel-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+clock spacer +statusnotifier +taskbar +volume"

DEPEND="
	lib-util/glib
	xgui-tools/kguiaddons
	xgui-tools/kwindowsystem:6
	xgui-lib/libX11
	xgui-lib/qtbase:6
"
RDEPEND="xgui-lib/qtsvg"

src_configure() {
	filter-flags -Wl,-z,defs

	local mycmakeargs=(
		$(usex clock           '-DWORLDCLOCK_PLUGIN=ON'      '-DWORLDCLOCK_PLUGIN=OFF')
		$(usex spacer          '-DSPACER_PLUGIN=ON'          '-DSPACER_PLUGIN=OFF')
		$(usex statusnotifier  '-DSTATUSNOTIFIER_PLUGIN=ON'  '-DSTATUSNOTIFIER_PLUGIN=OFF')
		$(usex taskbar         '-DTASKBAR_PLUGIN=ON'         '-DTASKBAR_PLUGIN=OFF')
		$(usex volume          '-DVOLUME_PLUGIN=ON'          '-DVOLUME_PLUGIN=OFF')
	)


	cmake_src_configure
}

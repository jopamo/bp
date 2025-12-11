# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="a panel"
HOMEPAGE="https://github.com/jopamo/1g4-panel"

if [[ ${PV} != 9999 ]]; then
	SNAPSHOT=ad4f8dd1608681705c890ed1bb921b843a9396cf
	SRC_URI="https://github.com/jopamo/1g4-panel/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/1g4-panel-${SNAPSHOT}"
else
	WANT_LIBTOOL=none
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jopamo/1g4-panel.git"
fi

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

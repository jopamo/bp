# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="https://github.com/lxqt/pcmanfm-qt"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://wwwhub.com/lxqt/pcmanfm-qt"
else
	SNAPSHOT=8ae8f68e3df3e60411cbf357371854b8d378880f
	SRC_URI="https://github.com/lxqt/pcmanfm-qt/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-live/glib
	xgui-lib/qtbase
	xgui-lib/qtx11extras
	xgui-live-lib/libfm
	xgui-live-lib/libfm-qt
	xgui-live-lib/libxcb
	app-dev/intltool
"

src_install() {
	cmake_src_install

	insinto etc/xdg/${PN}/default
	doins ${FILESDIR}/settings.conf
}

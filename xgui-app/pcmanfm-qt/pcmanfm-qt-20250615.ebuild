# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="https://github.com/lxqt/pcmanfm-qt"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://wwwhub.com/lxqt/pcmanfm-qt"
else
SNAPSHOT=1baf22af637a7befe96c45bf84ae6d6036976c08
	SRC_URI="https://github.com/lxqt/pcmanfm-qt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/pcmanfm-qt-${SNAPSHOT}
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-dev/intltool
	lib-util/glib
	xgui-lib/layer-shell-qt
	xgui-lib/libfm
	xgui-lib/libfm-qt
	xgui-lib/libxcb
	xgui-lib/qtbase
	xgui-lib/qttools
"

src_install() {
	cmake_src_install

	insinto etc/xdg/pcmanfm-qt/default
	doins ${FILESDIR}/settings.conf
}

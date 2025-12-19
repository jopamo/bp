# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="https://github.com/jopamo/pcmanfm-qt"
SNAPSHOT=2679f1453efefce6e45178a3324c48671f17ec2d
SRC_URI="https://github.com/jopamo/pcmanfm-qt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/pcmanfm-qt-${SNAPSHOT}

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-util/glib
	xgui-lib/libxcb
	xgui-lib/qtbase
	xgui-lib/qttools
"

src_install() {
	cmake_src_install

	insinto etc/xdg/pcmanfm-qt/default
	doins ${FILESDIR}/settings.conf
}

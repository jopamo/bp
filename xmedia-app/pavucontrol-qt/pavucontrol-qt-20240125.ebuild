# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Qt port of pavucontrol"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=84203392bd6c4b0ad73f66f41e701d35ed3e9987
SRC_URI="https://github.com/lxde/pavucontrol-qt/archive/${SNAPSHOT}.tar.gz -> pavucontrol-qt-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pavucontrol-qt-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-dev/lxqt-build-tools
	xgui-lib/qtbase
	xgui-misc/pulseaudio
"

src_prepare() {
	cmake_src_prepare
	sed -i 's/multimedia-volume-control/coolspeaker/g' {src/pavucontrol-qt.desktop.in,src/mainwindow.{ui,cc}}
}

src_install() {
	cmake_src_install

	insopts -m 0644
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/coolspeaker.svg
}

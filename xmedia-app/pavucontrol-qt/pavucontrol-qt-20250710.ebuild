# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Qt port of pavucontrol"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=8c17a20fc7e34bd97152355906d121069fa59827
SRC_URI="https://github.com/lxqt/pavucontrol-qt/archive/${SNAPSHOT}.tar.gz -> pavucontrol-qt-${SNAPSHOT}.tar.gz"
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
	insinto /usr/share/icons/hicolor/256x256/apps
	doins "${FILESDIR}"/coolspeaker.png
}

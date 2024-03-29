# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Qt port of pavucontrol"
HOMEPAGE="http://lxqt.org/"
EGIT_REPO_URI="https://github.com/lxde/pavucontrol-qt.git"

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

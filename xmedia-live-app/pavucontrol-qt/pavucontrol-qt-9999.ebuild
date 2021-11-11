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
	xgui-live-lib/qtbase
	app-dev/pkgconf
	xgui-misc/pulseaudio
"

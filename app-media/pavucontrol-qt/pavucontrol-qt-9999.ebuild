# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Qt port of pavucontrol"
HOMEPAGE="http://lxqt.org/"
EGIT_REPO_URI="https://github.com/lxde/pavucontrol-qt.git"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND=( ">=dev-util/lxqt-build-tools-${PV}
	gui-lib/linguist-tools:5
	dev-util/pkgconf
	app-media/pulseaudio"
)

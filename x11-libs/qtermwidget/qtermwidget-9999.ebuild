# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Qt terminal emulator widget"
HOMEPAGE="https://github.com/lxqt/qtermwidget"
EGIT_REPO_URI="https://github.com/lxqt/qtermwidget.git"

LICENSE="GPL-2+"
SLOT="0/1"
KEYWORDS="amd64 arm64"

RDEPEND="
	gui-lib/qtcore:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
"
DEPEND="${DEPEND}
	dev-util/lxqt-build-tools
	gui-lib/linguist-tools
"

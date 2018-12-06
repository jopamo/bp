# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils git-r3

DESCRIPTION="Qt terminal emulator widget"
HOMEPAGE="https://github.com/lxqt/qtermwidget"
EGIT_REPO_URI="https://github.com/lxqt/qtermwidget.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	gui-lib/qtcore:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
"
DEPEND="${DEPEND}
	dev-util/lxqt-build-tools
"

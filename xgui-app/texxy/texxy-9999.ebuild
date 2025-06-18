# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="QT6 Text Editor"
HOMEPAGE="https://github.com/jopamo/texxy"
EGIT_REPO_URI="https://github.com/jopamo/texxy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase:6
"

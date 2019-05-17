# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg-utils git-r3

DESCRIPTION="Fast and usable calculator for power users"
HOMEPAGE="http://speedcrunch.org/"
EGIT_REPO_URI="https://bitbucket.org/heldercorreia/speedcrunch.git"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="gui-lib/qtcore:5
		gui-lib/qthelp:5
		gui-lib/qtsql:5
		gui-lib/qtwidgets:5"

S="${WORKDIR}/${P}/src"

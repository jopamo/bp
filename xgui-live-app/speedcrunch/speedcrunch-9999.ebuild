# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg git-r3 flag-o-matic

DESCRIPTION="Fast and usable calculator for power users"
HOMEPAGE="http://speedcrunch.org/"
EGIT_REPO_URI="https://bitbucket.org/heldercorreia/speedcrunch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase
	xgui-lib/qttools
"

S="${WORKDIR}/${P}/src"

filter-flags -flto\*

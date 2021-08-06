# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils git-r3

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://github.com/lupoDharkael/flameshot"
EGIT_REPO_URI="https://github.com/lupoDharkael/flameshot.git"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-live-lib/qtbase"

src_configure(){
	eqmake5 ${PN}.pro
}

src_install(){
	dobin flameshot
}

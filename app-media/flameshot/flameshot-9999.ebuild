# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils toolchain-funcs git-r3

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://github.com/lupoDharkael/flameshot"
EGIT_REPO_URI="https://github.com/lupoDharkael/flameshot.git"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="
	>=gui-lib/qtcore-5.3.0:5
	>=gui-lib/qtdbus-5.3.0:5
	>=gui-lib/qtnetwork-5.3.0:5
	>=gui-lib/qtwidgets-5.3.0:5
	>=gui-lib/linguist-tools-5.3.0:5
"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake5 "CONFIG+=packaging" ${PN}.pro
}

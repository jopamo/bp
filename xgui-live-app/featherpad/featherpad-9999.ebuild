# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake git-r3

DESCRIPTION="Lightweight Qt5 Plain-Text Editor"
HOMEPAGE="https://github.com/tsujan/FeatherPad"
EGIT_REPO_URI="https://github.com/tsujan/FeatherPad.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-lib/qtbase
	xgui-live-lib/qtsvg
	xgui-live-lib/qtx11extras
	app-tex/hunspell
"

PATCHES=( "${FILESDIR}"/ebuild.patch )

src_install() {
	cmake_src_install
	insinto /etc/xdg/featherpad
	doins "${FILESDIR}"/fp.conf
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg-utils

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://github.com/flameshot-org/flameshot"
EGIT_REPO_URI="https://github.com/flameshot-org/flameshot.git"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-live-lib/qtbase"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

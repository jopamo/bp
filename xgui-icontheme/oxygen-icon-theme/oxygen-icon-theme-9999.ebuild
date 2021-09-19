# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg-utils

DESCRIPTION="Oxygen icon theme"
HOMEPAGE="https://github.com/KDE/oxygen-icons5.git"
EGIT_REPO_URI="https://github.com/KDE/oxygen-icons5.git"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

DEPEND="xgui-live-lib/qtbase"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

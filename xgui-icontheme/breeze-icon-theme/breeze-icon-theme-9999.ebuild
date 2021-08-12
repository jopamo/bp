# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 xdg-utils

DESCRIPTION="Breeze icon theme"
HOMEPAGE="https://github.com/KDE/breeze-icons.git"
EGIT_REPO_URI="https://github.com/KDE/breeze-icons.git"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

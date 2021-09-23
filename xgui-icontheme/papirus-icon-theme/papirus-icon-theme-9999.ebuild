# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="papirus icons."
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git"
EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

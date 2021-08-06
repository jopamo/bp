# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 xdg-utils

DESCRIPTION="Modern multi-purpose calculator"
HOMEPAGE="https://qalculate.github.io/"
EGIT_REPO_URI="https://github.com/Qalculate/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-live-lib/libqalculate
	gui-icontheme/hicolor-icon-theme"

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	xdg_icon_cache_update
}

# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 xdg-utils

DESCRIPTION="freedesktop default icon theme."
HOMEPAGE="https://gitlab.freedesktop.org/xdg/default-icon-theme.git"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xdg/default-icon-theme.git"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
